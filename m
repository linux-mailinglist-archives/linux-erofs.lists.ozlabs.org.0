Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DC2607217
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 10:25:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtyFd2gcPz3drW
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 19:25:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1666340709;
	bh=jm07VsSBrPUaMVoSP5/z4wtVUIt6SaNnSvMM79M3Wug=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=nYI3QcC7Kd3xVvIk5c8y7Dw8dfqgP+bU0FjWe2OMHs/QDqml2ASzSx+tmGCR6lae8
	 pYCpJ/9pfpB5q25KW1OHvJovu/j9+08hNQ7Qew/YbvE2e+Ob6Fg1m5VXV12/TBfc8r
	 HIR4zbbGbjq27wiGlWbU6oA6nuQQGLRe4IzJROhQ44raqWBcGhYN3kdmUKHLsKc/A+
	 toiyhjeoG9flSk0MBADFgXcgTXXeOq8/yU25Hb9WFwxn4nMBpd4R7MAAiymAnHP2G3
	 Jx8Y+O564gmvivQmRzCVHYPz6QZ6qCfo7iyGJjtMKF2a9xucm8S4dwIRx8TZmClzcM
	 VTL12maWbH/eg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=amd.com (client-ip=40.107.244.83; helo=nam12-mw2-obe.outbound.protection.outlook.com; envelope-from=luben.tuikov@amd.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=X6QGUtby;
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtyFX2z4kz3cBV
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 19:25:01 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8LvNUk9Q6pOhpphnuTNwUeYu09d8YUuPgDXbDg+ze/uKcbDlzFy/JuTASwD9bSFspUg+V5JoXYmEYEb2r4B6NPxc8enBnrjv/k5FRbn0YuKPsSMcvB5wOOnCVJibkws5STK7al5iLZqtowyK6e/goVn40hfNchm0hEEMUdHHWttMrj8d/TZB0IPfCcsi+pXK9TN+ZMxqlBNZg/U9ssM4hrSNgtQg62Oyys0ZcugEvuDcmW6ZI94J4B4Qal0EcJzBlgNkNwxGNkH+4m9N4naH/6Nqkwd/ePqomCyaMxydwWpQN5nKeAs6+OcdN7w/a1/1MESlIUHwqfXt56KEbuKkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jm07VsSBrPUaMVoSP5/z4wtVUIt6SaNnSvMM79M3Wug=;
 b=Z0FUYYOrA1t0EmfLjxL+FeOHNEAFy1h/aazisGg7BdWet3zvDU5PHmHKswdMQlRpy6nNkmwU5PdcchOOnrBBuIkRgjH33XH4/p/te2k0ebDZ7uRrzkkb8rnu9PqKeaCXLWMuk55ITRrSwvm8SwQhyfAwM9KQVLYYMXjpwNVjglTwRrywzga+zEqtEymbgZNYka6nQELCMZY2QbsLbNLQty4noGbpOM3y0CFhQo0lXHHU1g0ahZZIBHDBZ1a0jfV6378O7JU/8cDpFHTadAZZh6NiMGBtA30DkE3mKKe5/JiyGwD6ZqXUTrWpAXWEYQvcr/8Nocu7GAwOp9HmbwFdHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 BL1PR12MB5175.namprd12.prod.outlook.com (2603:10b6:208:318::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.30; Fri, 21 Oct 2022 08:24:40 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425%7]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 08:24:40 +0000
Message-ID: <35e66c7c-ff25-efd3-cfbc-d06130687aa7@amd.com>
Date: Fri, 21 Oct 2022 04:24:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 00/11] fix memory leak while kset_register() fails
Content-Language: en-CA
To: Greg KH <gregkh@linuxfoundation.org>
References: <20221021022102.2231464-1-yangyingliang@huawei.com>
 <d559793a-0ce4-3384-e74e-19855aa31f31@amd.com> <Y1IwLOUGayjT9p6d@kroah.com>
 <5efd73b0-d634-d34f-3d7a-13d674e40d04@amd.com> <Y1JV1wxf/7ERAMhl@kroah.com>
In-Reply-To: <Y1JV1wxf/7ERAMhl@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::22) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|BL1PR12MB5175:EE_
X-MS-Office365-Filtering-Correlation-Id: f866f92f-57b1-4b96-bbc8-08dab33db330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	xMD/NPDP5VNlWVO8L/gKv33XptDJaT7her++bV0tVoGEmz1yUeMty5TG8n1K2gXde+W7EkiEN367m2gEgvBNwUMcuME58RiNPUsvFsAMDCERpj5UdNMz6NWLV4e5Gj7E1BE37qnz+1ztjG5WdXt2lym4x+cg2mFVjwHxx+igkbFOq9+RuNd81hvfbRjQtHbt3e5zXMZ5hdYVRUofamvKQTkkaZkPID3UYgV00NysiYGQM9eIOyv63rw+PgjoEaUiz6qyDmiDfIcIE6C34sMBzh58uKxqdSPNAXMiEpidUcOmC0qF97OU/OvDI3HgzYyf7owUf06pjr1SMsm+RUla8/zsZBA0Oy5fTiifPwdiNsSf5z3/loaGhoRUMFU0O8cwHPXp7hdfyvgQpqNT2/7tUt2set78I1ZpTZDxElHLKi6sxhycjy53ckTJX6iN5VF8J6YzXFzLLmHqd2DtlRkOVhd5Z2Fr2+opSkAzCRqIiPZlAkVHDEKjRfSW+eWSilEdJgt4nL1whJlYp4PSgkCYmUFbG0jNfcm2oF5SlYGul3GP2/uKMMRjAnEQ0BatPbZG9j/zqBuGZvAO69umJ4rOCMPuFvHkJrt8qHetYl6FLi2Vu4izx9ZzWt/7+iDqKYGdWJeAaV2qoks8hEfFUHHOQiSV9XVOzLJI/CX1833wk2d47H0vws1XT2Dm+0DCShnfKKgZDkUo92rJsiglJgfUK7r4BbOrXxf/6rGpzvvlzutJXgcrsK11XaOgQ+fPn9R9AZRF851kdKYID+pQ3SgEeJ0u2KizzRmlpvXJqtuqAN/HMim9WpTsnW1vEjGDfyDNqQRnrxKPL+R4r45sUMVigg==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199015)(41300700001)(53546011)(66946007)(6666004)(8676002)(66556008)(36756003)(31696002)(6916009)(7416002)(4326008)(316002)(6506007)(2906002)(6512007)(86362001)(26005)(5660300002)(66476007)(8936002)(66899015)(186003)(4001150100001)(2616005)(38100700002)(478600001)(45080400002)(44832011)(31686004)(6486002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?cHMzQS9wSFdaZGFqUlFUMC9weW9oMjlKaHpBNEJPcGVyOFNDejdEdVhSbmZm?=
 =?utf-8?B?QisxYTlpUGRZTUdSUmFQTkhZM25MQ1hNaDZaRmc2S05nQ1pteUlHRVg5QnVS?=
 =?utf-8?B?cHJYbFJRWFdqajBEVnllWTFDdk5IMkNMSDcyMEhnMXZ4V2dNYkRtQ1JwVkhj?=
 =?utf-8?B?WjhyNDJRaWxBdm0xV0dpbXBBV1B1ZHROWEJMOEtFOUJiM1JiekM1cW9KTjBF?=
 =?utf-8?B?V3ZTSVJCZ1VucGRxblVLZjhkZGpOMGdRQ1FxdXFUd3lvZU14cWY4aTVCc2F5?=
 =?utf-8?B?ZHhBNnZZTDBLMjNFaVVDTm1pSThid0hEZzVoblZwL05JNnFTVmJHMnVYTDJS?=
 =?utf-8?B?eDEycnc4V2wvRnpsOVBkdU1UcUpDZnhJWWlDbjZaVVA4bW1mSzBKcWU2NzRX?=
 =?utf-8?B?K2x4aURmRU5NalQvMGdqakRIWHlkMEgzVzhTRjRmZUhRam40NzgxcjlteFpB?=
 =?utf-8?B?Nk1EMHpqQm14ZklhOS9DZVNFV1VINWJwSzl3Y2lsMmpMa3RObjdzdEU3YTk3?=
 =?utf-8?B?VklMZWhWQzIraXZBVnc0L2lHNlY5MmdHMXY2K0dLTGpyQTlQWkt2eU1xQnRJ?=
 =?utf-8?B?a3hNUnVOUkcxNERRYUJQbnpSTlNJTlhGeVg2K0dCM2JhRTZWUzRCUy9tRll2?=
 =?utf-8?B?dGtHM0E0TUVDSXoyV3lmU3NoLzhPOGFDYlM3dmwrcE44cXAvSXBJWUF4QWRP?=
 =?utf-8?B?RnFmRzEwWXV4c3l4T2NMYWVFNWpJelR3SzN0Z3poVXhBbHhDYjJESXZWaEhl?=
 =?utf-8?B?NVJpY0xweWZiTkhMT1pmL0ExK2dIcFAxaE9jUWFiU1FQSWh5bkltSHc0di9V?=
 =?utf-8?B?dVhUS2YxU1dxWCtWZEFIbFBEWHpjUElkZGpDM2l2RThMSzg5L0s3WFdIVENI?=
 =?utf-8?B?K3c3ZCtYdm5oQytCUU1rQ3BCaEdxL2dhZXF2VWkvN3Fpb0M4WEFNL1JSVklu?=
 =?utf-8?B?KzVmMDhONXNlbjBUdEwzRTliMFdwbll4YXVaMEJJc2RBWWppWFRPdVRmSVhN?=
 =?utf-8?B?WERkZTRwd0tFck13Q3RDY0JmY1lMMVV0YnMzZ1NYRCswK2w3c2djS0xhYllD?=
 =?utf-8?B?eSs2Ym9uSklnUmNyRlZhbkFhUHFrK3JjRnNPZkIyK1dhaHo5d09BaXZOQlM2?=
 =?utf-8?B?amtEaWl0RVRpNlNPMHVramgwR21PRVdhZCs2NFZ0UHdwV2hkUENGdnFLa1VY?=
 =?utf-8?B?MkI4RGwwK3pGWXdOdmpCanV2THRFNkZnTURvT1FnRE95QVMwSFZMWDR4VFJp?=
 =?utf-8?B?R1NMS2htNWhJWGMvM2RzY2dqK0x0MTdXSStFZlJsSEFNMkNSVXNLeXdPU2tC?=
 =?utf-8?B?d2E5cjI4SldlWFhUcVYxU3cyRkF4cW1RNTdLbFV6ZTBNMlJBNWlQTEZaNlds?=
 =?utf-8?B?K1ZVeFAxQmp0Z1dra3hRNXJka29nVjFuU3JtWENoTkJQWlhmS25ET3FaZmFl?=
 =?utf-8?B?aFBHWFBsWkh2RkY4ZXJBaDhaekxZd3RIam52SGMvOVBrMmFIbUMyVWZwSDAy?=
 =?utf-8?B?LzFudDJKc0NRRHk3R2Y3Rkt0MnI3N3Bsak04T2NiS2ZqWTR1VW1CMk5xdVFn?=
 =?utf-8?B?OUk1WmJReTBMSXpIMDZwZEpBSzcwU2dUZGFWT2MwV1NaNkhvTndaWDJoMFd4?=
 =?utf-8?B?cFR0KzNIM3JNa3p3WXBpZU1DaDBBdHBLa0Zvall3Ni9aL2lYUUo0K3NVWFg4?=
 =?utf-8?B?WjRWQWNNblFSNFV6TVIxbFJvcWZFRFlPY00yMldkY1hnMGhGRnpVZkhyUlFZ?=
 =?utf-8?B?dHlJYWdrcHM3V2prNlpUcjZwaXkySi96ZVlkY3VsYU9RRThpZTRWUW96MW8r?=
 =?utf-8?B?c0owUUpZL2N2YmI3dmRiSjN3V2I0L3l5ZFlFY2dzaS9WWmEzR3VvNU9NeWgy?=
 =?utf-8?B?eVFoMTlFQWdYVCtGVU93UFA2ZHdZNkNhM1hIcHBseWN2T0lUN2tJOFhzWUF1?=
 =?utf-8?B?c2NYS29QejFSU2FOU2dUblREZHoreE92T2I1MDNGMWVBVU5sODlZRGZvZ2ov?=
 =?utf-8?B?V0VQd2Z1UlRRREJNWXVGSmhYeU41ckxoQkhZN2tTbnlaclprZmVOSk0xUXRR?=
 =?utf-8?B?by9sUkNEWlVEQ2pXVjIyTDBpTlp1dGIwb25MUXIxT3lTam1yL1ROeUx4cjdR?=
 =?utf-8?Q?Xbr5c0oknzn1MGy5QBaxVnPxS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f866f92f-57b1-4b96-bbc8-08dab33db330
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 08:24:40.8913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wYZHP5R30SRzVYiONYOV1e9prBEC9BTN2tK4W+nm7fRGf63YHyP6c1SQ2i5S282d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5175
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: Luben Tuikov via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Luben Tuikov <luben.tuikov@amd.com>
Cc: rafael@kernel.org, qemu-devel@nongnu.org, liushixin2@huawei.com, joseph.qi@linux.alibaba.com, linux-mtd@lists.infradead.org, huangjianan@oppo.com, richard@nod.at, mark@fasheh.com, mst@redhat.com, amd-gfx@lists.freedesktop.org, Yang Yingliang <yangyingliang@huawei.com>, hsiangkao@linux.alibaba.com, somlo@cmu.edu, jlbec@evilplan.org, jaegeuk@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, alexander.deucher@amd.com, akpm@linux-foundation.org, linux-erofs@lists.ozlabs.org, ocfs2-devel@oss.oracle.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022-10-21 04:18, Greg KH wrote:
> On Fri, Oct 21, 2022 at 03:55:18AM -0400, Luben Tuikov wrote:
>> On 2022-10-21 01:37, Greg KH wrote:
>>> On Fri, Oct 21, 2022 at 01:29:31AM -0400, Luben Tuikov wrote:
>>>> On 2022-10-20 22:20, Yang Yingliang wrote:
>>>>> The previous discussion link:
>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F0db486eb-6927-927e-3629-958f8f211194%40huawei.com%2FT%2F&amp;data=05%7C01%7Cluben.tuikov%40amd.com%7Cd41da3fd6449492d01f808dab33cdb75%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638019371236833115%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=C%2Bj1THkHpzVGks5eqB%2Fm%2FPAkMRohR7CYvRnOCqUqdcM%3D&amp;reserved=0
>>>>
>>>> The very first discussion on this was here:
>>>>
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Fdri-devel%2Fmsg368077.html&amp;data=05%7C01%7Cluben.tuikov%40amd.com%7Cd41da3fd6449492d01f808dab33cdb75%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C638019371236833115%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=pSR10abmK8nAMvKSezqWC0SPUBL4qEwtCCizyIKW7Dc%3D&amp;reserved=0
>>>>
>>>> Please use this link, and not the that one up there you which quoted above,
>>>> and whose commit description is taken verbatim from the this link.
>>>>
>>>>>
>>>>> kset_register() is currently used in some places without calling
>>>>> kset_put() in error path, because the callers think it should be
>>>>> kset internal thing to do, but the driver core can not know what
>>>>> caller doing with that memory at times. The memory could be freed
>>>>> both in kset_put() and error path of caller, if it is called in
>>>>> kset_register().
>>>>
>>>> As I explained in the link above, the reason there's
>>>> a memory leak is that one cannot call kset_register() without
>>>> the kset->kobj.name being set--kobj_add_internal() returns -EINVAL,
>>>> in this case, i.e. kset_register() fails with -EINVAL.
>>>>
>>>> Thus, the most common usage is something like this:
>>>>
>>>> 	kobj_set_name(&kset->kobj, format, ...);
>>>> 	kset->kobj.kset = parent_kset;
>>>> 	kset->kobj.ktype = ktype;
>>>> 	res = kset_register(kset);
>>>>
>>>> So, what is being leaked, is the memory allocated in kobj_set_name(),
>>>> by the common idiom shown above. This needs to be mentioned in
>>>> the documentation, at least, in case, in the future this is absolved
>>>> in kset_register() redesign, etc.
>>>
>>> Based on this, can kset_register() just clean up from itself when an
>>> error happens?  Ideally that would be the case, as the odds of a kset
>>> being embedded in a larger structure is probably slim, but we would have
>>> to search the tree to make sure.
>>
>> Looking at kset_register(), we can add kset_put() in the error path,
>> when kobject_add_internal(&kset->kobj) fails.
>>
>> See the attached patch. It needs to be tested with the same error injection
>> as Yang has been doing.
>>
>> Now, struct kset is being embedded in larger structs--see amdgpu_discovery.c
>> starting at line 575. If you're on an AMD system, it gets you the tree
>> structure you'll see when you run "tree /sys/class/drm/card0/device/ip_discovery/".
>> That shouldn't be a problem though.
> 
> Yes, that shouldn't be an issue as the kobject embedded in a kset is
> ONLY for that kset itself, the kset structure should not be controling
> the lifespan of the object it is embedded in, right?

Yes, and it doesn't. It only does a kobject_get(parent) and kobject_put(parent).
So that's fine and natural.

Yang, do you want to try the patch in my previous email in this thread, since you've
got the error injection set up already?

Regards,
Luben
