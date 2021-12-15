Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C66475158
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Dec 2021 04:28:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JDLLB4NBfz304V
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Dec 2021 14:28:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1639538898;
	bh=rBvDo+LftPN26/qd1uK3rd8grllOTi7ZfLuc2KaaD8Q=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=FQl3gCN7D5VmEbFicRkTnyItiTI7lo6Xy5PvgRZmwroVMUYYIUjZvDmtR1vfC3mrL
	 xfazM4RLQllzexydeYSHc91psyk079YsdoUy/vzk2YiliYQDe+vy5QVQDORkdExUuD
	 /HDo9KuNn1MpoPKqYN+hrzSCabaU83C7MfZKMMj/ozqgaQLVsCs8Ncqgh1QxC6qsFv
	 H1GxAvSwwAcDRK/bHWdZo16fw9pZ8iBHkpBzZumkEu5xDkmueXHV3BmIQ+snCfo8Nm
	 HyFsJWcKVHJhX+mGloY7pb0skxu+fSft2cTnj+HJSVvYg1MavEoojCLwUUCAeyy1ix
	 Z2XQfcdK7TYog==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=2a01:111:f400:feab::609;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=FZXHdf5E; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sgaapc01on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feab::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JDLL53h4hz2xtP
 for <linux-erofs@lists.ozlabs.org>; Wed, 15 Dec 2021 14:28:11 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ft7dy+serZtSFCkBIkSgF5BPaG+4JZ7ivz/FCLUEGWGj8gqjA8OL9cyLeEC04QRSFzZEdZqFzFs04Gc8+0jLuRtzA/134qvIo99qpPfHiyPL+/MKFsVrjJk3rui+25R5A9ZFoiaelHWYF3sKyic1EKXdtK9Z+aWIWmZGaDjQbhKv+j7Ehq1ulAL3WrcRrp/CHz0BqtpyzPoJM38O5bO2HuTVy9dP/FNlnHCTckreN3/yXIhkw6F9V+DadTrXVMWEjoD0/5XZH+06TSU3CI8HOUztOAg9wInS74v/zlEhv8ZvwnvThwJehmVmfGiq3zlB8ZdGokUJrnHTDBieha9GAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBvDo+LftPN26/qd1uK3rd8grllOTi7ZfLuc2KaaD8Q=;
 b=F2ZXqcJm/2hC2JBojSNOr9Euhd4hNCJKs1vnZPKYBBB1lU3nPIWf6yPL5Fz7A4o2/6Xu2EWcN0QkR6xIGarOafiA200v9IiCrnYqqxGxznOpwm1CPS08MGBo5XsmTNb34DFvxBeaJEye/mWgwB/zxF+Alu3jl0AYVjUq4wfoZU06hh6CphTf8uzYGGscoC6QvdVL4F9JYmsdZXxV2zKocivHPtIrNyeQF6dwPDZZol9F8BMlv71jFapfZhGFB9xPlT40qhpmlN/9hBES6nXIuHaxLsbMuWT/bmTVjTpN88AqShaxxTsCJoV2RE2J2keLyXq8Dnh5uR3FsOhM8x146g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3019.apcprd02.prod.outlook.com (2603:1096:4:5c::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.24; Wed, 15 Dec 2021 03:27:49 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::3032:4149:e5d7:982a]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::3032:4149:e5d7:982a%3]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 03:27:49 +0000
Message-ID: <f96bfbdc-86f8-0dab-ae05-a6c32a87a7c0@oppo.com>
Date: Wed, 15 Dec 2021 11:27:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 1/2] erofs-utils: sort shared xattr
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <YXE30+2qU75+0szk@B-P7TQMD6M-0146.local>
 <20211214095202.11717-1-huangjianan@oppo.com>
 <Ybi4was1yPMNlNqV@B-P7TQMD6M-0146.local>
 <2decd4e7-506f-6156-15b0-148ba5cb3089@oppo.com>
 <YblfdNxSEBhx6b3T@B-P7TQMD6M-0146.local>
In-Reply-To: <YblfdNxSEBhx6b3T@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR04CA0052.apcprd04.prod.outlook.com
 (2603:1096:202:14::20) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0eb97d73-2fcf-47c6-23bc-08d9bf7ade64
X-MS-TrafficTypeDiagnostic: SG2PR02MB3019:EE_
X-Microsoft-Antispam-PRVS: <SG2PR02MB30194CDED0B3FBE7ECD58670C3769@SG2PR02MB3019.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JbQWHUrYlSFd7RWcbYDX4+wGdN+lHsqA+sZirxK901bIpgNlseBsMnUCEcMPbhltMt3FNoozXh7fdGC1obDuhbwUhkRkDKV8BImKwIVCjoz+OxInJ8ItwY0pm9bCPO/gWXWeIkpAM3gQ/Limqd0P8lSBEIj3BDDnieAMRvZ9CDw1iq32h58iFfJmSyn0nK8HOtsEITm20c3LSxiuqgn1Pflkf+hZ6SYIu+A3pMhvzKNaFjlY7kADutPdHxuRoCB8PMauL+YEnPfeHG0y0ezeKtq9c/7WWfblYfG4Bp+oDf+MvCNdkpHOJC7B3AMe6NuA3yhcHPA7JGalQM2ZrduetcddbrNA4BKs2SfhG5aM1QnACpHPXmBR6C/dlqybo/7TBk4/BSkH1Z2r6xYg5Cvvpzds6SWZrrahOZTLJyF0v/s1UYTQLhU+L+/THwhyKfD+aZaj1IWEjohNZnpY9ggJ56mU7UMGTU3qCtGA0SWlF5AC/tGp0fEsIBrmUSHiHFK7/YmXpM2Pniql24EmflIqwbSqDSypVDNbolcnpTvfrDovpxWdtJzJFrZUeOKojVP8KrCvWebyWG6cykMLOiuf3VV00y2TtfrIYPyjTEH5B77evs6KGkTyjXB/xev09G04qY/VN56wZn2/cba4Zp962/t/hbAwMYEz961VazIaXSWlcZ5SNrrDYAtGaHMEuanYdBGnvh5NWekESDdxM/sSBieZ+6vSo90Gz0k+wY7lDvyepweaoUPWJzDUYsqYCqwTBOtmTkK8VoNJQCLGlboko3jxyhDCVjlN58HYDlDy7Cg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(31696002)(86362001)(316002)(52116002)(4326008)(38100700002)(66556008)(66476007)(38350700002)(186003)(31686004)(66946007)(6506007)(2906002)(36756003)(6916009)(6512007)(6486002)(107886003)(8676002)(6666004)(508600001)(5660300002)(8936002)(26005)(2616005)(11606007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2xMcWpjQlRRWkZsS3JUTDFuaUk0cXU4OWV5WjY4eUtSSzBrbnFCaWVuNjR5?=
 =?utf-8?B?aW1kWGlURlovK0V5RUQrOUdiV1pLajRxK3BVK2hSYWhObjNUNS9ob2tmY3Vv?=
 =?utf-8?B?VlZpT1Jkc3JteXdWaGcwWmVlL2dTbFZIUGxYRU45c3lmK1hLcStnZHQ3QmZK?=
 =?utf-8?B?S2VvU3FHMWg1YXZleERXMmcvMHJwU1ZvTlZxaHFwamlHM3AvQVQ3ZjgyYWpa?=
 =?utf-8?B?T2REaVNId0RsRWhoem1LbU5nVFNsbTlBQVIwMzJ1ck10N1YycXNjc2U4Q0kv?=
 =?utf-8?B?L1pBZVNxSmIrK3Jpekx3Tk9PTW1nRzdGMUVOZFRMemlpVk0zM3VuYXk2blV1?=
 =?utf-8?B?cmp6TW05TjFXVXZqcTVxM1BweXpheXlPN1puZGVNbkxYbzI3VUN4clM4T1Ju?=
 =?utf-8?B?L1JpOW5DaHBsN1p0dFpHSmFWVSswNHNSM0U2cXNJNExPbXI3bEp3Vk01MXF2?=
 =?utf-8?B?RHBBVGh4UVVINzVNcnFsTlBYMnh1Si9DOGlTcjcvU1BDQkk2endXdGtXOXlH?=
 =?utf-8?B?TG1HSFR5RTZCSEJMelpTRzlNNmkzUGUvRE1nUUU4R1YydzFmZ0ZzQVdjdVRj?=
 =?utf-8?B?d0Q1Z0NTV0h5WFYvS0szRDQrYmRGRndBZTJiSXVDY1A1UDFwL0QvLzllZmRt?=
 =?utf-8?B?Z0NjaEFKM1hLcHNTTzlEbWRTaVcwb2gyZ25MZnVKMFF4ZTF2d1FYMGxkUi90?=
 =?utf-8?B?VEl2R3UwUUxqdVZrV1hSMThRUWdDY3N3Z2cvMkdLa0FUQmcvbXZnZTlZb3RC?=
 =?utf-8?B?TVBWMldRait5Q0xVR2J0eU5iYW9aNmJ4K1pGV1c1dVdONnVGRDVKVDNwdmR0?=
 =?utf-8?B?dWxLd2pCaDV0MVZ2MStIaERVL05NZmpJa3o0amt0UU9MWjZGeHFOTkE4akRq?=
 =?utf-8?B?bnRjN3ROTU42V2hremVvS2cvd1Q2MnNFY3owWlBQaXNTN0dZUVIzQzd6Q09J?=
 =?utf-8?B?VjRrVDNYWUFOWDRUTjg3VFZlS2xCQXhGMUpVZVc2Z0Q0WEZXZncwWDFjMlNu?=
 =?utf-8?B?dmVvWno1K1BFTTNOVDVkaUN0alJZN0xGWDkzYWU5T3h2bzZrcHkrRHJGMjFE?=
 =?utf-8?B?WFpvSnB6TnJKd2pDZW1IR0lvYU1YTW45YXQxVHI4RzZ2SnQrRG1sKzRpS2VP?=
 =?utf-8?B?T0ZSWFU2NnF3dU5WeGk2bzdOb0c4ZGZWUjNrd3VXbVBSeUpsWms4TmtVUzMr?=
 =?utf-8?B?K0F2eWR1MEZwb2t2R3orWUFWdjR1emgxa1Z0VkZMbGpxVVlad096R2FwTG92?=
 =?utf-8?B?MnpJdWpsVGVNVnpTU0pndW5YanJ0M0ZTa0FrYmNpcGR3cytqZkRvbVJITkt3?=
 =?utf-8?B?bFBaTlVHaVF5QS9MaWtXYUlHZjFkeVNkWThVb3I2OWNLdGVka2xhSlBiWDh0?=
 =?utf-8?B?OHFjNW93UC9QYm1GU2FLdkpmNENOR3pHd2NnM3lvV3hkcXlDRmVmU0d2aFIr?=
 =?utf-8?B?djZVc3J2cElLWEhsSWZYbWFSNHN3ZEN6VkdMVlhHTUxUVnNaTzAwQTg4T055?=
 =?utf-8?B?TjBEMG5CbkR0S282TExoYmVheENiZHhHaW5TYVNxcytFOWFOYUJIM05FMFEy?=
 =?utf-8?B?U0hvRHQ1ZG94ZUJPSTFVTXo3OGhES3MvMlIrSjY5WVUwTTBCSVVkMEx0SjIz?=
 =?utf-8?B?emtZamVlRk5SdUFyMlRXQ1JJWjJOUVR1NUJ0YUFCYVlUTHFiMFV3NUhveE5L?=
 =?utf-8?B?WEY1ZVYvRStmYnJndlJkamVBV0VnZ2x4TmpaZnl3dUtQbk5PaDJtQ1NhY3J5?=
 =?utf-8?B?bW9rVUtpN3AyYmlQK3hqT1ZwUWt3bHFqK2kvbmhiKzZiNVNZMWhieUg2Z3c3?=
 =?utf-8?B?SEtGWlNpazZKY0xQejRGYk1xajZ2YzRZNVpFeC9FenkwOVZKbXJSWmFzbVVx?=
 =?utf-8?B?c2RsclZUODEvd0tnRFBiUjR5amxvcE1YV1EvMXBiQnNUR2ZhcHlQNjhmSU9J?=
 =?utf-8?B?b01TeDhaUzFuNnFsT1JIc2t6UkdjRVc0ZmZpRlZua1lWN2JKcTlGT3ZUNFc4?=
 =?utf-8?B?YlY3YmkwRGlMMlluMStJY21lbnJOSXZ1RjBpazJsY0dqMS9haHVQRGdSbDNZ?=
 =?utf-8?B?NDc5NFBDeWZVSDZpZ2p6cGgxMkJhOUlOa21NN29vQjFsVWN2U0JVSkNhd0VC?=
 =?utf-8?B?UDl4V3NQQ1hOWFo3OGdrRzBOeVN2WTVMTUFsSlB2d3E1QnpvTyt1am1lVEpK?=
 =?utf-8?Q?jFPQXkmOm4khJpRXIi9r6rw=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb97d73-2fcf-47c6-23bc-08d9bf7ade64
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 03:27:48.9843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miFDkQP7YWDJ5y60lDuY4iDN4OAKiznpsH/mp9IZ9kh+uys2gV5uq1wicRO9kDenMjjrpSE1ubjVkZc1eVVXcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3019
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

在 2021/12/15 11:22, Gao Xiang 写道:
> On Wed, Dec 15, 2021 at 10:43:40AM +0800, Huang Jianan via Linux-erofs wrote:
>> Hi Xiang,
>>
>> 在 2021/12/14 23:31, Gao Xiang 写道:
>>> Hi Jianan,
>>>
>>> On Tue, Dec 14, 2021 at 05:52:01PM +0800, Huang Jianan via Linux-erofs wrote:
>>>> Sort shared xattr before writing to disk to ensure the consistency
>>>> of reproducible builds.
>>>>
>>>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>>> I still fail to understand why the order of shared xattrs will be
>>> a problem of reproducible builds.
>>>
>>> IOWs, if the order of shared xattrs is really a problem, do we need
>>> to sort inline xattrs as well? Or do you have some reproducer to
>>> show why the order of shared xattrs can be changed if the filesystem
>>> of srcdir isn't changed?
>> We discovered this problem when we built the same image content on
>> different machines.
>>
>> After executing readdir, the order of the subdirectories returned by the
>> two machines is different, which leads to a difference in the order of
>> shared
>> xattr. I'm not sure if this scene can be called reproducible build in the
>> strict
>> sense.
>>
>> In addition, since the problem is caused by the readdir sequence, it should
>> have no effect on inline xattr.
> So it sounds like we need to optimize xattr readdir process instead?
Agree, currently xattr will prepare before sorting the subdirectories , 
I will try
to put the process after sorting.

Thanks,
Jianan
> Thanks,
> Gao Xiang
>
>> Thanks,
>> Jianan
>>> Thanks,
>>> Gao Xiang
>>>

