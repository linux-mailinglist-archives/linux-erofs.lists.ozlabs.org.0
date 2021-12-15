Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC4147510C
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Dec 2021 03:44:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JDKMG5ZLKz3036
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Dec 2021 13:44:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1639536250;
	bh=1du4N7g3g/PnOKpMiADoIm7uUO8sGUYIL7RH6houU4Y=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=RM661PEzsE2UsrRZYxH+y9ncSoKwVU6FBM4cbI1m6/Qop96Pf6yc5Xn8BfoJaZ2S8
	 vQ96s1LFxDbMZMFT1pBhw1IDzsv6v8+HThEoxCmYd7cDCZd7LXRB/2n+4ZGXRhBxsh
	 q5rBF5yN1y0RRsBeEaIJls7ZFu4wxY3l/RDCJVmrOdl51YyLwUsl7sYFOrQPKEUtuG
	 Yg+G4OdcsmPCBjfAE31mV0Vppwrgexotw8rjQRZge7WooUxuK4T+gZKT+HOrObx4IN
	 FHbITJbzSzEJdgxZZgJr0WnXB8RFWYq6iwJ27rZS/cRgidZb9wYExm+Njve//3U4z6
	 kXE+OMVR43sWg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.255.40;
 helo=apc01-psa-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=c9ug5BdU; 
 dkim-atps=neutral
Received: from APC01-PSA-obe.outbound.protection.outlook.com
 (mail-psaapc01on2040.outbound.protection.outlook.com [40.107.255.40])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JDKM76l6dz2ywm
 for <linux-erofs@lists.ozlabs.org>; Wed, 15 Dec 2021 13:44:02 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1fgjsSn+juDJ0BMoT36BjRhHqMI9WqQNm6RpdN+UZ9fWJPIP5JRJSpL9D6VCltrfG83UYewz95tuOb8j7fVefeQbkuyCDFc4cCvorjUJMelj5PG9rpyww9dckqly/4FUZtRxJ9BjDrCwFDIRars+piVnZJKfGFuvIBdBKfeX+aYh8LAqFuURusI5sPCUr94IBvXICNf/05L/uxdeoyiJSMviJ9nm/MBkvf7EPhc8yjq9OrGhTFwpCw2VdKixswE30RUaGaEi3TICWVjzMlBiR4VkvJMK1NgVF5pXK8LnmdZt1BmiDReJ4MNLqe2T55V2kihETiEv9nQNRGDHQNeEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1du4N7g3g/PnOKpMiADoIm7uUO8sGUYIL7RH6houU4Y=;
 b=d8Sb7jzTxeRzyKYi86bPeeE59NzILQAAdL4Au2VCxvpD8cuLGnGnWXUEqK19O8H6zIfR78FIIgqVoWwKAJx9Dln3alVjNdUI7fqyFZZUwVrkI8fzr57Wf10VO2Fk2XUQTQMShZlV8vM8bJmAQC2bVAbG/DzmiFK5p/wSiA4IgjSYDxvelQWvtUebJVMPJMo8ds1VxFCdMpjRS57HVIgSHN9jEK7e2jlb4qdX6w368HOK+lTb2lVz28nWd4Juw+bM7Sp6mpCxDk9u6ygEcvS87hmWonMnfE5kNDEyQbuq1GyENxL4d9HmtkCCqmjVpDRat45Rt8k8UxBTuixE9v/ZYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3370.apcprd02.prod.outlook.com (2603:1096:4:4e::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.18; Wed, 15 Dec 2021 02:43:44 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::3032:4149:e5d7:982a]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::3032:4149:e5d7:982a%3]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 02:43:44 +0000
Message-ID: <2decd4e7-506f-6156-15b0-148ba5cb3089@oppo.com>
Date: Wed, 15 Dec 2021 10:43:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 1/2] erofs-utils: sort shared xattr
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <YXE30+2qU75+0szk@B-P7TQMD6M-0146.local>
 <20211214095202.11717-1-huangjianan@oppo.com>
 <Ybi4was1yPMNlNqV@B-P7TQMD6M-0146.local>
In-Reply-To: <Ybi4was1yPMNlNqV@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3495c3f7-d6da-46ab-75f8-08d9bf74b5c1
X-MS-TrafficTypeDiagnostic: SG2PR02MB3370:EE_
X-Microsoft-Antispam-PRVS: <SG2PR02MB3370691289C75D9F0E55651BC3769@SG2PR02MB3370.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Xg4x2CJ3ZKisxg9s3ouB91CiQx2h8bMFDSCPI81HMN85+U0KhE0GEP9YPIwljVujyRcJzPsYvC3KDQYqN3ZdQy7myyES8g38Ed5uTpVbO4IByZwb3HI/gdGFiLrRae2gX7NHmiw+DGihRVUnDSUJ9WZGRYNkLsCAzbdtRP37u+clt6khKmB7/GceFbEo6lGBsgmoSEcrQ6Set4teJNkB4FqlOcn25n3u+dsHuacziUNBy9O3JDreFa9QrkZdzBilGpj8QU5V2nYWQYxtIINjZy05mu+85edDwsBehr8ku1I2EL6OewQF5cvb5VjaG1qgAgJLMvE6ydIjk4yfCC5FGYq8iHdKtsbH7cY/SoBEtIGJ5gAVRigLYXQqA+XHaxsSbHiu2LQxkVRQkNnO1IhfJyfwSMtUah3TEcNHs+HDXNaDOcnwIMNztTM8FeegH6jpoex7ELDkX4eR8fIfu6GVr4pow4GyLctbrNs8V1IMSVeRwuYn7UKqwvwoS4v+4uOcz/SlS9kDKfeXlbIYvBnhTVQgGsjjbiT2iTjrRn96y6BXEKOT4iXqgsIqufmUvJ9HaKsLzoCi5RAuyD95ekys6SEyA5NUoB/ch9pIPVjir14TwL5pwvuzO9faOiCGvD4vinMGVq7cQyO+gtwZUiicV0E8b7ioCcyBw+aNKbovoZzoD9KZYzPw/nVi/uLcBwS6laODvV2lO/BaI2UZSLIhs3ILXNQtwI+vgqqiVJr7P8d33QSmy3d+GVm9mzdQ/Kv/RW81WgP39OkUYrvP3nH7gSgwFICc+Q1ZLe0Gem8ACs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(107886003)(2906002)(6916009)(4326008)(186003)(83380400001)(8676002)(31686004)(66556008)(8936002)(26005)(6506007)(36756003)(38350700002)(508600001)(6486002)(6666004)(38100700002)(52116002)(86362001)(2616005)(6512007)(66476007)(66946007)(5660300002)(316002)(11606007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG5XQm8wcnBOUTBFVXZuN203YzdyTFJzcHM0dGh2NU8zU1BybHl0OGg3ci9F?=
 =?utf-8?B?Z1JGMUtieTVkZTV6NWxLYWhET2tmQ1B6Wnk3QU5iVmN3Mnc4cEpmSTRJTThj?=
 =?utf-8?B?ZUVTSjRZcHFJVGlka2FqclhEV1pKa0dMZk5DTUVpVHNTbGlDOURndG1WV0RQ?=
 =?utf-8?B?c0dxZ1JCUFFoTThaS2ZNTWw2N0R4M0lvemdnQXFCekx4WVpFc2dUdFhyd1BO?=
 =?utf-8?B?ODRiNitRS1VKUGJjaDZmNGZTMVFvYXltaVZCbGRaMGhyWE1QUEF2a00vQmo5?=
 =?utf-8?B?dkhIOGZaS3dnWVNRaXdhTXlrM1lMTFBDdFJYTm1saWw0MU1xTWprYXUramlP?=
 =?utf-8?B?aVRkcS9TaVFxM0NwQlRQS3RqY0NtUGRjZTRUTDNwSEw2NzcxYWxvV1ppMVJF?=
 =?utf-8?B?UXNCVlhuKzZ1ZUc1OEFsNFpYMFFrMjAwRXBMODNwV3duZlhmV3NuVDJ4Sm50?=
 =?utf-8?B?ZEw4a2FvbFUreGxCQ2hDTHVKWkQ2UEN0Z2IxS3VDME5ZbkRXL0lnL1pIMFM3?=
 =?utf-8?B?N2NWSmQ5cEdZY1hTQXoxQjhDYm1nd0MvQjJrUjdQUVNGNk9vSHQ4YXRTNFA4?=
 =?utf-8?B?NDUyRVF3M1lVd0JuNkg2L2p2OUR5TXlvRU5mTGZ0ZnZkcnh6M1NOVW9DNDZ4?=
 =?utf-8?B?QzFMSEdOcmN2ZE9JK0lmbGIzbzhZYXdWYzJLYmN6Qlh2a1BCWFYvSkRXNHo2?=
 =?utf-8?B?UllsMzdNNmtXbDEvQndmVGtab2s0RVp0ZlZtZ2dHY3ZYSVdvOTU4RDdWNXMz?=
 =?utf-8?B?NEhGanVQKzBxMHhtdmNJM2pPNzJ2Q0RLTnpmYnBPczAydHdGRjQ2OTBBYnZk?=
 =?utf-8?B?dEUvODhyZXRtNjJqUngrTllJdm1qS29QQVo4WWgyN29melhKUDQ1RDZFWmdz?=
 =?utf-8?B?UGcyOFd0WGEvcnQ5TWhzd2xLUElqZjI2VUJLMkl5N3E3ZFFhY2dOd1RuRExs?=
 =?utf-8?B?VkhYa2RuMFFWa1BtMjNzeWxXcnJnSEhUa0NlTnp0TXRmZHRKdmxmeks4OEdk?=
 =?utf-8?B?RTVwenBPbUFHWFRJYWxtbzBVOEg0NjNobCtTRW84N21nc3Y0NUgwNklnRFFu?=
 =?utf-8?B?eURFcmRLYVBYYW9tSjZqNmV6WVkxWVRaMFVGSEhaTU1VUWZVeHhyVjNnM0kz?=
 =?utf-8?B?bzBOOFdzQnFJbFpreGRiNjlqU0tScVFEVit6Si9nN09sTjQvaW9WVHpZZzZP?=
 =?utf-8?B?ZWlPclJRVnZGYWczV0Vib0ZLUmNSL1NyaFVJTkpobGxCNnFGbkxCaS9IU2Fz?=
 =?utf-8?B?TDZjeENoV3MrbVBDd2dkR2swYU1XdzVpRFZOekQrRGwvTTJsalV2d3ROMnRj?=
 =?utf-8?B?ZDcyeS9wTmpMWHdwamxlekk0RVJVMCtJc0QwWEd2OW1nYXZ2Q0k3dlFCTmtD?=
 =?utf-8?B?c20zc00xL2Q2T3hWZzNKZDI5Kythd1JZdFB0NUVIb0hMYStKRDFrdk16SXdz?=
 =?utf-8?B?VzE3SHlrcFR4Tlpsamd1MHEzN2pKYmZtV3ZsanliWWthNVlaMkxPNnBldHJQ?=
 =?utf-8?B?c3N2eHhPZHkyUW1tY1UweHVsK2szM2oxeEF2Y3VnMHBMeVdjcFd1d3Z6b0Rv?=
 =?utf-8?B?NkdhK2lYYVA0d3pUM1ZaeW9RWmh0NDZGc24rUkphd20xRWZsUUlaYXI4czFR?=
 =?utf-8?B?cExRZTVGWnBuZDdYTmhLd2Q2SXFURGg2NnhJTGVxeWMxYUxrZyt2azNibHZP?=
 =?utf-8?B?UTBjQk9SNEJoV2tPbENvN21lY0hUdjlKWldXalpJOUx3TkFpc00yWkpyMlRM?=
 =?utf-8?B?aXZ5M24wb0J4MzZ6VExKNm9VM29FWjZTNUJEUE5iK05BeTIzekw4czlDRk5Y?=
 =?utf-8?B?MldCdkhmS0tSUldFdDJ4VlZrQkJLSWx4ZG5FQ1RKd0J6RGdJWmdCcGJUTk5I?=
 =?utf-8?B?RnRJd3lSZjAxdDY4eXR4V2YwdGI4MmxDK3M0SHBLZFF1MmZ2YVhYYmlxNU05?=
 =?utf-8?B?MmFlNmJORU1yMzJVUGNWNG1YZG13UmxKb0NNNlJjYnJsTy9GdmJlakdQOEtH?=
 =?utf-8?B?ZVQvKzBvNFdJWVFvQVBXelQ3aXJjQktyamZsOXdoVU40bGtDOVMyb0RYMVlY?=
 =?utf-8?B?Ti95Y2krVlVGSEFPR1dKOTdvdmNxL1F4VUJnM3ZHdzV0TisrN2MvaFFSYlpu?=
 =?utf-8?B?R0RtdmNxSmluczY0amYwTFg4MTRlcXN2aUxrVVZWa0xEci8rYk4wZmFMSlZJ?=
 =?utf-8?Q?U0HPModKzIlYOrUaZYEy6x4=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3495c3f7-d6da-46ab-75f8-08d9bf74b5c1
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 02:43:43.7977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQa4vYgXx+eeUy4oV0JsV8hTYma43X+WJ89lScmCzfqXV6LL6jhHyo5P3lxz0r4M0VqUZmnzLbcZlROiVEdOLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3370
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
From: Huang Jianan via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Huang Jianan <huangjianan@oppo.com>
Cc: yh@oppo.com, guoweichao@oppo.com, linux-erofs@lists.ozlabs.org,
 zhangshiming@oppo.com, guanyuwei@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

在 2021/12/14 23:31, Gao Xiang 写道:
> Hi Jianan,
>
> On Tue, Dec 14, 2021 at 05:52:01PM +0800, Huang Jianan via Linux-erofs wrote:
>> Sort shared xattr before writing to disk to ensure the consistency
>> of reproducible builds.
>>
>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> I still fail to understand why the order of shared xattrs will be
> a problem of reproducible builds.
>
> IOWs, if the order of shared xattrs is really a problem, do we need
> to sort inline xattrs as well? Or do you have some reproducer to
> show why the order of shared xattrs can be changed if the filesystem
> of srcdir isn't changed?
We discovered this problem when we built the same image content on
different machines.

After executing readdir, the order of the subdirectories returned by the
two machines is different, which leads to a difference in the order of 
shared
xattr. I'm not sure if this scene can be called reproducible build in 
the strict
sense.

In addition, since the problem is caused by the readdir sequence, it should
have no effect on inline xattr.

Thanks,
Jianan
> Thanks,
> Gao Xiang
>

