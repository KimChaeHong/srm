const pastelColors = [
	'#FFB3BA', // 연한 핑크
	'#FFDFBA', // 연한 오렌지
	'#FFFFBA', // 연한 노랑
	'#BAFFC9', // 연한 초록
	'#BAE1FF', // 연한 하늘색
	'#D5BAFF', // 연한 라벤더
	'#FFBADB', // 연한 장미색
	'#BAFFD1', // 연한 민트색
	'#FFEEBA', // 연한 베이지
	'#C9BAFF'  // 연한 보라색
	];


// FullCalendar Js
document.addEventListener('DOMContentLoaded', function () {
    var calendarEl = document.getElementById('calendar');


    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        locale: 'ko',
        headerToolbar: {
            right: 'prev,next today',
            left: 'title',
        },
        height: 'parent',
        timeZone: 'local',
        events: function (info, successCallback, failureCallback) {
            $.ajax({
                url: '/srm/myportal/getEventDate',
                type: 'GET',
                data: {
                    start: info.startStr,
                    end: info.endStr
                },
                success: function (data) {
                    var formattedEvents = data.map(function (event, index) {
                        var endDate = new Date(event.end);
                        endDate.setHours(23, 59, 59, 999);

                        var color = pastelColors[index % pastelColors.length];

                        return {
                            title: '', // 제목을 비워서 표시되지 않도록 설정
                            start: event.start,
                            end: endDate.toISOString(),
                            extendedProps: {
                                color: color // 확장 속성으로 색상 추가
                            }
                        };
                    });
                    successCallback(formattedEvents);
                },
                error: function () {
                    failureCallback();
                }
            });
        },
        eventDidMount: function (info) {
            // 이벤트의 테두리에 색상 적용
            const color = info.event.extendedProps.color;
            info.el.style.backgroundColor = 'transparent'; // 배경색 제거
            info.el.style.border = `2px solid ${color}`; // 테두리에 색상 적용
            info.el.style.boxSizing = 'border-box'; // 테두리 포함 크기 조정
        },
        displayEventTime: false, // 시간 표시 비활성화
        eventOverlap: true, // 이벤트 겹치기 허용
        dayCellContent: function (arg) {
            arg.dayNumberText = arg.date.getDate(); // 날짜를 숫자만 설정
        },
        dayCellDidMount: function (info) {
            // UTC 기준 오늘 날짜와 비교
            var today = new Date();
            var localToday = new Date(today.getFullYear(), today.getMonth(), today.getDate());
            var cellDate = new Date(info.date.getFullYear(), info.date.getMonth(), info.date.getDate());

            if (cellDate.getTime() === localToday.getTime()) {
                // 날짜 글씨에 직접 클래스 추가
                var dayNumberElement = info.el.querySelector('.fc-daygrid-day-number');
                if (dayNumberElement) {
                    dayNumberElement.classList.add('today-circle'); // 직접 클래스 추가
                }
            }
        }
    });

    calendar.render();
});




// 진행바 js
Vue.component('progressbar', {
    template: `
      <div :style="{ borderLeft: '5px solid ' + borderColor, paddingLeft: '10px', marginBottom: '20px'}">
          <!-- 슬롯 영역 (작업 이름 및 진행률) -->
          <slot></slot>
          <!-- 진행 바 -->
          <progress :value="value" max="100" style="width: 100%; height: 20px; margin-bottom: 5px;"></progress>
          <!-- 날짜 표시 -->
          <div style="font-size: 12px; color: #666; text-align: letf; margin-top: 5px;">
              {{ startDate }} - {{ endDate }}
          </div>
      </div>
    `,
    props: {
        target: Number,       // 진행률
        borderColor: String,  // 진행바 색상
        startDate: String,    // 시작일
        endDate: String       // 마감일
    },
    data() {
        return {
            value: 0,
            interval: null
        };
    },
    mounted() {
        var self = this;
        this.interval = setInterval(function () {
            self.value++;
            if (self.value >= self.target) {
                clearInterval(self.interval);
            }
        }, 10);
    }
});

// Vue 인스턴스
new Vue({
    el: '.progressbar-container',
    data: function () {
        return {
            items: [], // 서버에서 받아올 진행률 데이터를 저장
            colors: [
                '#FFB3BA', '#FFDFBA', '#FFFFBA', '#BAFFC9', '#BAE1FF',
                '#D5BAFF', '#FFBADB', '#BAFFD1', '#FFEEBA', '#C9BAFF'
            ] // pastelColors 배열
        };
    },
    created: function () {
        this.fetchProgressData();
    },
    methods: {
        fetchProgressData: function () {
            var self = this;
            $.ajax({
                url: '/srm/myportal/getProcessBarData',
                type: 'GET',
                success: function (data) {
                    self.items = data.map(function (item, index) {
                        return Object.assign({}, item, {
                            color: self.colors[index % self.colors.length]
                        });
                    });
                    console.log('진행률 데이터:', self.items);
                },
                error: function (xhr, status, error) {
                    alert('데이터를 불러오지 못했습니다. 관리자에게 문의하세요.');
                    console.error('데이터 요청 실패:', error);
                }
            });
        }
    }
});

