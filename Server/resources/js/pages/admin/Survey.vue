<template>
    <div class="container">
        <div class="card card-default">
            <div class="card-header">
                <h3>Survey manage</h3>
            </div>
            <div class="card-body">
                <surveyList></surveyList>
            </div>
        </div>
    </div>
</template>

<script>
    import surveyList from '../../components/surveyList.vue'
    export default {
        mounted() {
            //
        },
        components: {
            surveyList
        }
    }
</script>
