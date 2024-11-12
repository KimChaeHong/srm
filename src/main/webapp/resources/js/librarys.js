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
            info.el.style.border = `4px solid ${color}`; // 테두리에 색상 적용
            info.el.style.boxSizing = 'border-box'; // 테두리 포함 크기 조정
        },
        displayEventTime: false, // 시간 표시 비활성화
        eventOverlap: true, // 이벤트 겹치기 허용
    });

    calendar.render();
});




// 진행바 js
Vue.component('progressbar', {
	  template: `<div :style="{ borderLeft: '5px solid ' + borderColor, paddingLeft: '10px'}">
	                <slot></slot>
	                <progress :value="value" max="100"></progress>
	              </div>`,
	  props: {
	    target: Number,
	    borderColor: String  // borderColor prop 추가
	  },
	  data() {
	    return {
	      value: 0,
	      interval: null
	    };
	  },
	  mounted() {
	    this.interval = setInterval(() => {
	      this.value++;
	      if (this.value >= this.target) {
	        clearInterval(this.interval);
	      }
	    }, 10);
	  }
	});

new Vue({
    el: '.progressbar-container',
    data() {
        return {
            items: [], // 서버에서 받아올 진행률 데이터를 저장
            colors: pastelColors
        };
    },
    created() {
        this.fetchProgressData();
    },
    methods: {
        fetchProgressData() {
            $.ajax({
                url: '/srm/myportal/getProcessBarData',
                type: 'GET',
                success: (data) => {
                    this.items = data.map((item, index) => Object.assign({}, item, { color: this.colors[index % this.colors.length] }));
                    console.log('진행률 데이터:', this.items);
                },
                error: (xhr, status, error) => {
                    alert('데이터를 불러오지 못했습니다. 관리자에게 문의하세요.');
                    console.error('데이터 요청 실패:', error);
                }
            });
        }
    }
});

