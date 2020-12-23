Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F622E1A24
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Dec 2020 09:48:49 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D16Lk1Xb8zDqSk
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Dec 2020 19:48:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.132.48;
 helo=apc01-pu1-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=oppo.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppoglobal.onmicrosoft.com
 header.i=@oppoglobal.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-oppoglobal-onmicrosoft-com header.b=fbZB9Pkm; 
 dkim-atps=neutral
Received: from APC01-PU1-obe.outbound.protection.outlook.com
 (mail-eopbgr1320048.outbound.protection.outlook.com [40.107.132.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D16Ld5sy6zDqS5
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Dec 2020 19:48:40 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0q8007rgjXA55GwJQVvJhZ/ikD+VpkvbNRdPWh0IDIpShQ0kpOO5I5xSgAXDLL4JMWPaKrqu1l+WGPDQLgxh0Q01Wzgfwfms91nCYySSdnn5vB3CyGB9i2D6BKMwvIhz6piwq9aU5SXvaZnkBhGiDL8nicRsAFScVaN3aVfpDKXKkgrKLketdV+k+RVfWMEJB2V5U+rXCCDr6qI7F+1WuyXokjs9uxLkyVazcnsN3v/x7bXeFt5jmxjYXjuAwQku/KaBlCORt96VxyOMwoNghHDwPFLMN9DAdZnbodoYizBPGFdB9cZHIVuqDwIELWN6G8Ql21LML/r/eMO/KYI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRfvTV37giQfaSscfZulevH5sau0KwSINn8GFODWwhQ=;
 b=ja88XwQr1qwKmzRpYWP1ZfOBGFlnHUQ3STxIBS2STjY21xoTs67RAktvyHwJoZnO9y18hhRbJipcaILgkUQuVwu0ZeUtqY1WvAy1itmm2qPQnuygGalz0aeR+8kc9mpbKTFhGmcMTrKcGSWlXaiyTj5TV3YthGSBXoNx80VBG+Y4mLEAvQ9dd6JsqV3eer5DvdOnyJTJdj3xzIU8XjQYgQJo78zVgHOfpdHrsSaMu2l2yhkUS/+u9xGmsdcMq51a41olrtD5oEXwZvuM45uvFtetPcsD1LDnFCG90wTw6tOPBgIq71VL2Uhen7ELFSXje7gmXY140wLh9EmMcASmbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oppoglobal.onmicrosoft.com; s=selector1-oppoglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRfvTV37giQfaSscfZulevH5sau0KwSINn8GFODWwhQ=;
 b=fbZB9Pkm0YO00qfFmullFq+WCLChosUJKuzJjKCuZRvr5Uu0jJDf4KboWy9I0A+kCF2v30A7N0XzGH93bsdT7WQTdEaZTvPcN1C0WJnJQrUpcwGF/zp/tOO1Toufx+KrEFmqxZA7ZEbNfwABwa471KSKXTHUQuJmRmEfx4XCoH4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB4428.apcprd02.prod.outlook.com (2603:1096:0:8::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12; Wed, 23 Dec 2020 08:48:23 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::dcd:13c1:2191:feb7%7]) with mapi id 15.20.3676.033; Wed, 23 Dec 2020
 08:48:23 +0000
Subject: Re: [PATCH] erofs: support direct IO for uncompressed file
To: Christoph Hellwig <hch@infradead.org>, Gao Xiang <hsiangkao@redhat.com>
References: <20201214140428.44944-1-huangjianan@oppo.com>
 <20201222142234.GB17056@infradead.org>
 <20201222193901.GA1892159@xiangao.remote.csb>
 <20201223074455.GA14729@infradead.org>
From: Huang Jianan <huangjianan@oppo.com>
Message-ID: <dc4452e9-83eb-90e7-f001-d39d0ecdd105@oppo.com>
Date: Wed, 23 Dec 2020 16:48:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20201223074455.GA14729@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK2PR02CA0220.apcprd02.prod.outlook.com
 (2603:1096:201:20::32) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.118.0.32] (58.252.5.72) by
 HK2PR02CA0220.apcprd02.prod.outlook.com (2603:1096:201:20::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.27 via Frontend Transport; Wed, 23 Dec 2020 08:48:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17e0e99c-00e6-446c-b073-08d8a71f81e5
X-MS-TrafficTypeDiagnostic: SG2PR02MB4428:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB4428CD9ED11B85E1D17EA489C3DE0@SG2PR02MB4428.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bL/zfSvMcVrLVCUvTCFKCVl4Ka6somg4WYtdACcLdMwZapRGuFkuUn6YE88mzxOvEJnu4yvC5bpnQVR/GV2Bz32jlk1oZuzhG+KcfDQ0Dbz7iB23F6NwozuJ93qkZkmNcj5q3siBaG2pM0akK9NZrHeUCnnk6A/1nHxbhZEK8+woDDmQGqg2TErgo6Ue2N86l2wZc/5cZxg36XsXNOQ4Jn1hzPzxtkEi4S5/49dHXD4SSVi8s57E7fgNtBoSSgzmXpShs2dgXuZP41+xXE+jisSSlEFc8WXo51/bDuhSsNAB9vVrVlo9vdNdp2s4oyQJRXLSuwPxIkRA1ebrZDKTz8JLgT+5Gqf76D1Svolh0h6+n/pYZn90BB/xy2KRpK/Pm0bt+rBUnnjuEgTiV+All/Tou4SUcsmafYW9aQ+8v4cKjFhRQFWBY7oOu9rG+JD9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(366004)(39860400002)(346002)(83380400001)(16576012)(66476007)(6486002)(31696002)(16526019)(4326008)(31686004)(2906002)(316002)(478600001)(186003)(5660300002)(26005)(36756003)(66556008)(2616005)(52116002)(86362001)(8936002)(66946007)(110136005)(956004)(8676002)(11606006)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?gb2312?B?NGZvWGZEUlNsY1hPcWxLUUswbkJyNG1wdGV0WnNaeGhxQnVQYmZURHFPQ1kv?=
 =?gb2312?B?TUxZUklGbGVadDlZbGtSMm51UzE3UzgwM3ZobFp0UlBidDdBT3grQnFSTENz?=
 =?gb2312?B?b3AveEcrZkwzaVB1UUN4bmdZQkI1TFBIbUJnN0ZxM0NlMFpReEtGRVdncHda?=
 =?gb2312?B?NlR4OGdjWS85NTU3TVR1MWFIKzYzR3lBM1czaWlycWRPZVkweGNjSVR0OE9n?=
 =?gb2312?B?cWhyWTJFL2NEbERkVUNRb0ZzbDl3Rk9WOXdKNnp1Qld6NjVDZ20rSUZiTDVJ?=
 =?gb2312?B?YkszaFlMQ1R0VWN3cThOd2g5L1RWNTlBV25rdy9zT0FzSGlDeW4zclowUDhO?=
 =?gb2312?B?MmJGY0VmZ25rdmkyTkZCM3puQzhhTFp0ZyszWjFrNVFPdjNDRmU4djdDOU83?=
 =?gb2312?B?Wk45Sm1TaDh3UWt5NDlqYkZvcC94UUNUOGE4Yk5lRC9MUkZlaExmREs5b0JL?=
 =?gb2312?B?WExOdE5HSytyTEYvQ0FBQXAzK0RDMWlBY1F3d3lKZ2QrYnF3YzlLRDV4SlRj?=
 =?gb2312?B?aHUxeE56NlBxVmFnZFZ6SzBrVDNNOVZCeEtKTDBNL2prRWF2UGVhUjFjRVZG?=
 =?gb2312?B?RHJtaEVUWUptdGRoUlJKR0VMM0JwdXRnL3dyMHFaempLMkttNG9NOEovT3Zk?=
 =?gb2312?B?Y0RFRWR1OS94YXlrMUhRc29QWi9neEFNUTlnMDY3c2lOMGNlT3pxb2VDMFdV?=
 =?gb2312?B?Z3NhdUp5VTdiUU9PVGROZE95MDZLZVN0UTdrZ1VMZ29UbUVOblpoak0vMDRw?=
 =?gb2312?B?eXVhTGNSWE8rR214UERRb2NlRW4yWmhNZVJSR3lwaU82SHdXUnc1NGx0cHpZ?=
 =?gb2312?B?YllicTBkZ25OU09vejQzc3dHeStxUHdsQkk0bFlMc28xUGZvdzRMMDVKRXpp?=
 =?gb2312?B?c3A0NkNpeWRPQnE4eXQrVU5SUDZmbHJ4T1V2TzE2b0JNaFoxQzQ1NW93WStr?=
 =?gb2312?B?WGdBOTUvRkw2U0R5cFNNbytONlRYSE5USnJLamdCUEE5MFU2WnJwZnZTMGJk?=
 =?gb2312?B?M0E5WWY1UWxOT1AyY200Mm1SMmZEdUFCNzF1U2xZVkpaNlZvZUp5QXdQZHJ4?=
 =?gb2312?B?c2NMMzUzeCtlQVBEdUtZUW9mdGwyWW53c05kcER6YW9ZU3RIZE5ET2ZUa01K?=
 =?gb2312?B?eDFyS2ZaZ1QzdnpzVG9IcE5CaGI1dG9FbGtvVkttOFBzZXEwNUJHVzNzYXg2?=
 =?gb2312?B?amNBMmhzY3R6VzVxS2U4ME1iK3ZubWdlcUo5K3EzcXBUY0FMdUlhVkRPODdp?=
 =?gb2312?B?MU9jMXJ2U3I1T1F5dUYxNjA0K0p5VWdWMlBzaXlSaU5nSG9renloSGlySGN4?=
 =?gb2312?Q?tFQfPstmZZ1zw=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2020 08:48:23.7184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e0e99c-00e6-446c-b073-08d8a71f81e5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/qCMAN2bdgeMegvozy0quoMyppIb9iWLyjulDB73vZUgPA81tveOFl4XErdwTJq0yT9naqwOV++b0ybYNvliw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4428
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
Cc: guoweichao@oppo.com, linux-erofs@lists.ozlabs.org, zhangshiming@oppo.com,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christoph,

The reason we use dio is because we need to deploy the patch on some 
early kernel versions, and we don't pay much attention to the change of 
iomap. Anyway, I will study the problem mentioned by Gao Xiang and try 
to convert the current patch to iomap.

Thanks,

Jianan

> On Wed, Dec 23, 2020 at 03:39:01AM +0800, Gao Xiang wrote:
>> Hi Christoph,
>>
>> On Tue, Dec 22, 2020 at 02:22:34PM +0000, Christoph Hellwig wrote:
>>> Please do not add new callers of __blockdev_direct_IO and use the modern
>>> iomap variant instead.
>> We've talked about this topic before. The current status is that iomap
>> doesn't support tail-packing inline data yet (Chao once sent out a version),
>> and erofs only cares about read intrastructure for now (So we don't think
>> more about how to deal with tail-packing inline write path). Plus, the
>> original patch was once lack of inline data regression test from gfs2 folks.
> So resend Chaos prep patch as part of the series switching parts of
> erofs to iomap.  We need to move things off the old infrastructure instead
> of adding more users and everyone needs to help a little.
