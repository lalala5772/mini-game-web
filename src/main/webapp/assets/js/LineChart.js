// ChartManager.js
class ChartManager {
    constructor(canvasId, chartType = 'line') {
        this.canvasId = canvasId;
        this.chartType = chartType;
        this.chart = null;  // Chart.js 인스턴스
    }

    // 📌 차트 데이터 설정
    getChartData() {
        return {
            labels: ['1월', '2월', '3월', '4월', '5월'],
            datasets: [
                {
                    label: '신규 회원수',
                    data: [10, 20, 15, 30, 40],
                    borderColor: 'blue',
                    backgroundColor: 'rgba(0, 0, 255, 0.2)',
                    borderWidth: 2
                }
            ]
        };
    }

    // 📌 차트 옵션 설정
    getChartOptions() {
        return {
            responsive: true,
            plugins: {
                legend: {
                    display: true,
                    position: 'top'
                }
            }
        };
    }

    // 📌 차트 생성 메서드
    createChart() {
        let ctx = document.getElementById(this.canvasId);
        if (ctx) {
            ctx = ctx.getContext('2d');
            this.chart = new Chart(ctx, {
                type: this.chartType,
                data: this.getChartData(),
                options: this.getChartOptions()
            });
        } else {
            console.error(`Canvas 요소 #${this.canvasId} 를 찾을 수 없습니다.`);
        }
    }
}

// 모듈 내보내기 (ES6 방식)
export default ChartManager;
