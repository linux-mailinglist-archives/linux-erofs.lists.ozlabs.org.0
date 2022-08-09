Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9BA58D2B5
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Aug 2022 06:19:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M20FR6HRlz305d
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Aug 2022 14:19:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1660018747;
	bh=SSuROhfyCNfnD9EMnDLbWyIDBJHcC0/ke9uMQh/1Jro=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Bx1C1tQT0kDwZVFl2uzUJcEKWa2KNikXMFtRftuXhCKHnA16yts1R/fLU1BjqFKgj
	 Jsk2qNSkPKdxTZOiFpCLOn/6FpoE7urzHX1tudPUbv7/vttn0SYnStFvdy7Yt7aTxu
	 CdOFrio6DNTMVl6i/0ebaWnSu/fAyDYQTNKFRDE3iAN4E/GfV6YGiun+NJ8HZtJrZQ
	 AHFxbgLo6D9pe7ffxFA3vIL1DK1Z1HzadITahKNwwQ8adqkOTKstskGAvR3e/6lSLr
	 T9PAJrtLb92nsj5SsKieLeGvbaCGcG2hN+CJu6tpK/76/zj80ePWsj5MgFisRCc0ub
	 24EZyaH3FeH1g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oppo.com (client-ip=40.107.255.78; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=shengyong@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256 header.s=selector1 header.b=Wvd38FeT;
	dkim-atps=neutral
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2078.outbound.protection.outlook.com [40.107.255.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M20FK5YtRz2xH8
	for <linux-erofs@lists.ozlabs.org>; Tue,  9 Aug 2022 14:18:59 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrbeYtf8wGIziTvwteNcmtoClCJt6XuhuRbc1it/EcBQFybKe/uvbtMPK1eP3gY/iB8uCVzJzrSystOHY/o5ssjT+5k/uy1VnGRhxY07A4j4w6rGtfNvYDw0GAbAbLVzEoLahNCIklLXKUXS1xAhWth+gY2RZBExRswC/fyfYYBeqPBtayWJicSGgDveqr5J0gT9KVePFCD3OHFHbAcunIXUCfmcp/Bi8eT/8c0YhDANoXSVzLf7MxtLbZVr2oBemtiDWAGGjoU5sLhp7uEP2r8ByMij8pi9KIDB7SdoRP7kq2W2vJnlu6gjGt9Wl9qg9PyJScLdgB4TmEUrnXBW/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSuROhfyCNfnD9EMnDLbWyIDBJHcC0/ke9uMQh/1Jro=;
 b=aTL5cshO6yUQib1yqsaxAqkNvEW7gF5Y1DunBCdfnDHn/zBGG2+fte7P2uQUAMhK/vYwcGGVvws0uDb48Hx6uFMs+EFLYl35FYWgKeicg3Hgnorledzej9PmkB+9fEf5BoGs2ixLbNTvQL5DOI8NHEwtLEqbMbxicogV2Yye76EimrkgNhw0jSVIv+gRPQ1K+V309YQ6rNRKxbHlomCVT1BjPTMsLf8Pq6CVbTIRwaQGrzPNiLiGvYvz3QTPCLBGdXicAoOb1v0sbv8FHeoh9iA+wOWaUJZj3yuiNiIU5aquaC8m3ngvwaCsk+sz6I5VdPLbt3JI8CkxQxBdOV4mPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com (2603:1096:4:153::6) by
 SEZPR02MB5887.apcprd02.prod.outlook.com (2603:1096:101:73::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.21; Tue, 9 Aug 2022 04:18:38 +0000
Received: from SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::adea:6739:ab8a:9adf]) by SI2PR02MB5148.apcprd02.prod.outlook.com
 ([fe80::adea:6739:ab8a:9adf%3]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 04:18:37 +0000
Message-ID: <76efd3fa-e760-8321-8bb7-c7cc1daa9fe1@oppo.com>
Date: Tue, 9 Aug 2022 12:18:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: [RFC PATCH 2/3] erofs-utils: fuse: export erofs_xattr_foreach
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20220803142223.3962974-1-shengyong@oppo.com>
 <20220803142223.3962974-3-shengyong@oppo.com> <YurQkH7D/Ch/clT0@debian>
 <YvHbZrYUU7qDP0Jg@B-P7TQMD6M-0146.local>
In-Reply-To: <YvHbZrYUU7qDP0Jg@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To SI2PR02MB5148.apcprd02.prod.outlook.com
 (2603:1096:4:153::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 730a14d1-5b0f-4f5b-4077-08da79be3b98
X-MS-TrafficTypeDiagnostic: SEZPR02MB5887:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	CQOsIcJH8XecCxt/zCf5ZR/ijRqqxh+rCkjMl38hpUDKOJF6lHOZXeFWI5CFuxpT/E5GpBZsyliSl+x8G4Ggmx138S7x8Om/qGKnEtxg9aOaWJU6Yu6S6tWgqfP2tYVkojdeibmogQt+DnrON3iIezQ1V1kuHBldTlwIzwczuiXdowuIZx5oyUWiq6lul43R6oMRsR3JopERI8hjRtmNiP8Yyx55VBZJ5RxwHPae6K4euUgwsCdF1TcAR6jEghALe8BBTSAj4myrgBHR+l6BEibDahG7emerwyxbMRU+yGqK0SDuUgN1P0AN6/iSEYkmp2nLVV/WC0OAY1PIggyYFJpiaeMX2VJ09Aw4JGWJHbKN9WhQAkiqTnAKeF1AEt1GuckalUUGs8mdpukYFDB6jMqU45bV7SmX/2U8lhpXFFV9myaYn3s7UVr2dPrD4DGLgLQoYfn3yMCE3q180EmFgjEscjo6oIH3PnPxWJzaBeLfuQb4bWndBbn9No93ke53eAj5AQwoUIWyNM1NtKpMdoH7683PdkeeTxFoUKvQvTtE2dz8Opjsmr93XmCo4Rh8afhF5x0lxThQjeIlwr2jzKJypBfGIFiSDQvlAdIXED5kKfucgIPUPivTp+E31KncZHKEs35Q/dEseu+jQeLl1o0U380UeTpxdysQXpM3l59+rTRyytNJ+Pen2BpnEhV88Vcyt9QqqC0ageaODpWjOXD4am9hGElWtasRtCRYTygVcTtnfvY1FNKGRQPIeWJlT7KJMyESMDhlNCMj+YjV2w96Pvr8oM5YsJvyqjxyp1ZdRbUXJARwL/Bsux9Ug0Hxxh6YU7ECbCBw4fbk6CO5AIoLqigK9D4QAWYwbARndg7nMNqqSr1WjIqf4TLkA/t9LBSaVgJ0/7GMsoyzvTDMEA==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5148.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(5660300002)(26005)(52116002)(38100700002)(8936002)(36756003)(186003)(41300700001)(86362001)(966005)(2616005)(6512007)(6506007)(31686004)(6666004)(6486002)(478600001)(6916009)(316002)(2906002)(66556008)(8676002)(38350700002)(66476007)(4326008)(83380400001)(66946007)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?K1FGNlgzM1VCMTlkZVFHTmQ3VStEM1kvSlVSK2Y5SFlNUW1NWmw5OWZrU2Fq?=
 =?utf-8?B?b1RQVzBvLysveTBIbUZoNDV0QTAweEhHUGdTV0dCTVpPYm5uQjkvbE5IclZD?=
 =?utf-8?B?clF2N2U1TVpYMkVKSnhydDJRWnd0Y015SkRCUWFOZG1wbmFiWk4waDlTdUdy?=
 =?utf-8?B?NndBYjkvZnR6NWl2RCt2Z3o3b2psdjVqVXZUVnl2Wk1QaGFjL0hkV0RKRFhO?=
 =?utf-8?B?a0pMbC9MOVA2UFNRVXFKS1orN3ZyVnBibHRGWm94cjdHVnlYQnVVK2dHWHBy?=
 =?utf-8?B?cE96RTJ6T0l6emJMdTQ2YWI5bnVBTTN3eTBVRGIza21rQmpEMDlPTGlTaGUv?=
 =?utf-8?B?SFlNRjVKUEpkZ2ZmclRIbmRTZVl3aFNGK2JweWpnUjhSSlhrYVVBaWZLKzk3?=
 =?utf-8?B?TE1BYmw4VzhLMTh6MzhFdTNFWUE2dm5IL3ZiVDUzOUhiZUpHOXZudzZLeExL?=
 =?utf-8?B?dXNMaklwdmd0aXZFMnBrQnN3Z2g1aWhQdGsxeEROOGZOL0R5YXBHb2pTSVBZ?=
 =?utf-8?B?eFBNc3FtVFA4aFlpT1BHUkd0TG55c29lb0pUZU55RjFuOStrOEJKREY5a2dF?=
 =?utf-8?B?akpMUERlQXA3dHVVQlBrczczTWJtSkM4NUpuMXROUTMzalo5WEpNSGhGUk9X?=
 =?utf-8?B?eDQ0Q3JWUGJ3aEszT0pzV2E3bTFiZnhIN1NrRXRqejlEYUkxanpGdVdwZXdp?=
 =?utf-8?B?bmtTQkV4SUN4Y1Q4SW8wVFRNdk1GNnlkV3dZNVM2alBUaE5KL0dwUzhGd01G?=
 =?utf-8?B?dWpKcEk5TnZZcGU4bnVBK3JHZjdkWTRFblhUN3RzZ0wzRXJFR0dlYTJqRUVG?=
 =?utf-8?B?aGdhWjBEZ0pSeWNHZjFjMlZySGNhaStRVTF4azluVlREcDFHNlZOb0hoOGJn?=
 =?utf-8?B?ajJyaWN1MGxVMTVlQTZuUDZ0YXhHajNtWlZrQVZSZUN3WFZlU1NhS1paa0Fh?=
 =?utf-8?B?L05WWUJGOG0vVTg3anBiTVBXWXE0ck5uZjdTQk5SaW5OMFZ1aTJ3clB3V3VT?=
 =?utf-8?B?aUdSa2Nidmk2WktEdVR0eC9IdUsySFFneE5KL28wVjlua0xQVmNZYzFlVGlE?=
 =?utf-8?B?TitHK3cxZmoycVF6clgyRTBpOENPY2hUU3Q2N2pCd2orS1FPKy9zcHluOGQ0?=
 =?utf-8?B?ZFRlaWU1UXFqZ3hvTy9DTWFUMFFMM3NVYkJuK2ZNRTNUMVNDZC9OYkJEOG9s?=
 =?utf-8?B?L3duY2hOemJZeS9TU0Z4RFJ6QnRFcUc3cDE1SWJuNFh2MDRxWVV5YkVuWTlZ?=
 =?utf-8?B?S2FsSVg1QWprazVrakRTd1UwcjVuOTNacTQ5dnZHUm96RjZWVmdHM2hCMkNV?=
 =?utf-8?B?SnJ0RnRuQS9QYlp0L2lOTWJFK3FHTDhFbTdReDNKclcvMTlZUWUzcnhHajBx?=
 =?utf-8?B?N2tKY0IzOWRvNDZ3cXF2RTlsYXBVK2psbkN0UHJIOG5JdDlWdGh2OFYwWWhJ?=
 =?utf-8?B?eXZwdEF0Q1Q4bHBLaGpoM2o2ZzVqc1JHYit3ZGRhT0FLMTJ5RU4vamxtK2kx?=
 =?utf-8?B?aXIyazVmOFZVaE1idFYrTFhFN2NKbG5HdGJsT1lOUkxPYm1yM3crV2t3cHFp?=
 =?utf-8?B?bEVHSGlmS21Ld2VYcVZTL1U2cXRJWWNNRXVZN2dhOE92MDREcDJlYU1QWVN1?=
 =?utf-8?B?c1A3SGdjWmM5b2wvMXE0bW01OE1kYWpKMVN4d2NGR1VKUTYwNUUyYmRWT2dT?=
 =?utf-8?B?T2pGZCtFS3ZLVXgwS1dUNWtSVHhnSHlPOWIyZG95aHlVRVdBUHJpbEwzVXoz?=
 =?utf-8?B?blpEb0R5UlJTbk1BRVNESE1NU2IyUHFKSUNRYk5rNTBXTzFCUmQyVUcvcW1a?=
 =?utf-8?B?QTh2dUttUy8vYTFaS1Z2RFFXRWpFZW9LUTh2cjhxdk9aT3pZT0R3d1pXT2RB?=
 =?utf-8?B?MzQrT1FUYWpQZWhlcmJmUWVUOVVVa0FQa3R5dVV2MDdmMENubXNxSWJGWEdM?=
 =?utf-8?B?c0RkZk81Unp2ZkRTalZJdzVpeEtVRS9aTjNkRCtlVVVwQjVHeGV3dlk5R2RB?=
 =?utf-8?B?NzEwaXk5c0cvdCs0M2w1Q2g2VnpUYmlXNm5DN0FrZysrRnh1VGIwaS9qOXJM?=
 =?utf-8?B?SzR6dTVTMExNaE9JSCtuUnBMaXlLOStib014Mld4dUNxRFZmTFBacTIrK2FT?=
 =?utf-8?Q?7W/AHWK0GPG9qnvjXqNLsR0Ej?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730a14d1-5b0f-4f5b-4077-08da79be3b98
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5148.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 04:18:37.8332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7raN0/kd/8aH2dxiOVOI7/wad6drKwQXgX8hfflKyF1yHIjKvLXxGd6Z/3QmQFOF7/UMKn70XH8SlhWq2QG+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB5887
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
From: Sheng Yong via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sheng Yong <shengyong@oppo.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



=E5=9C=A8 2022/8/9 11:58, Gao Xiang =E5=86=99=E9=81=93:
> Hi Yong,
>
> On Thu, Aug 04, 2022 at 03:46:24AM +0800, Gao Xiang wrote:
>>
>> On Wed, Aug 03, 2022 at 10:22:22PM +0800, Sheng Yong wrote:
>>> This patch exports erofs_xattr_foreach() to iterate all xattrs.
>>> Each xattr entry is handled by operations defined in `struct
>>> xattr_iter_ops'.
>>>
>>
>> Thanks for your hard effort!
>>
>> Could we import in-kernel xattr implementation with verify enabled
>> (or unify these implementations) instead?
>>
>> ( Jianan ported a kernel implementation before, could we enhance
>>    it with verification?
>>    https://lore.kernel.org/r/20220728120910.61636-1-jnhuang@linux.alibab=
a.com)
>>
>
> We're about to fix FUSE extended attribute support... Would you mind
> leaving your opinion about this?

Hi, Xiang

Sorry for late. At first glance, I though it would be too heavy to port
in-kernel code when I tried to add xattr to fuse client. But if we want
a more unified implementation and Jianan has already done it. I'd like
to try Jianan's version :-)

Thanks,
Sheng Yong

>
> Thanks,
> Gao Xiang
>
>> Thanks,
>> Gao Xiang
________________________________
OPPO

=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=
=BB=B6=E5=90=AB=E6=9C=89OPPO=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=86=
=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E9=82=AE=E4=BB=B6=E6=
=8C=87=E6=98=8E=E7=9A=84=E6=94=B6=E4=BB=B6=E4=BA=BA=E4=BD=BF=E7=94=A8=EF=BC=
=88=E5=8C=85=E5=90=AB=E4=B8=AA=E4=BA=BA=E5=8F=8A=E7=BE=A4=E7=BB=84=EF=BC=89=
=E3=80=82=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E4=BA=BA=E5=9C=A8=E6=9C=AA=E7=
=BB=8F=E6=8E=88=E6=9D=83=E7=9A=84=E6=83=85=E5=86=B5=E4=B8=8B=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=E3=80=82=E5=A6=82=E6=9E=9C=
=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=
=AF=B7=E7=AB=8B=E5=8D=B3=E4=BB=A5=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E9=80=
=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E3=80=82

This e-mail and its attachments contain confidential information from OPPO,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you re=
ceive this e-mail in error, please notify the sender by phone or email imme=
diately and delete it!
