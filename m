Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D7544E025
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Nov 2021 03:09:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hr28M5Qf0z2ym7
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Nov 2021 13:09:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1636682963;
	bh=BAxffUKF/sWX8pscCe4DeFmF58fGL0MkV9sloVvnjyg=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=CXzjk0OODF7rJlpiVZy8pbhmMRTvYVA9vg/E5NbzO/JfO5Ys4XjuPUfCAlYts0N7T
	 BVDgDBhr9AKD6Mt0bEzE+OV/kgeVyh1Eq2lEbZ/oqXYq/0yHl8lcmOphHv+vWXqQKk
	 Ki68zRajw7TQcLLNJjW73PMBcsdUpneQM5OGlz3TlYH9LNQ+roEIjM1DdZ6eRsL/dX
	 ZXn4TZwc4l9P0RyrsdXRKxuSJPnvja9eua8h+sdU0tR23+YVHNbmyF50p+vzicsPfe
	 t7g/voIutVAeot/HSc4feWSOhDE6tbJivGzL2+2hyvgRC/xvIn4IQVotnx4maKK6j6
	 oM2liF+B2anVg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=2a01:111:f400:febd::621;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=TiFR/sqm; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sg2apc01on0621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:febd::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hr2882jmQz2yHM
 for <linux-erofs@lists.ozlabs.org>; Fri, 12 Nov 2021 13:09:08 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TD0mrGzqUQDqNmA9KoO63WlnOPGkOdTJp/pkcB/vMVtqgHh5Pe205nvQFLH4kZS6C6QFWAOGvLJejZgj5OmWJ5FKqInkHIVn0gQRg1Ojyc5YTphI2+AH5PpckGuiAHvTNZF7MH8VqungEhdrUROtXbcrZwF78eNX2GHsB/fHjxokQy4yFAOb7aYSDc5ouQmxa9DJDoEhDS8dhAiMiriNmvZPALm/8gyhKagHoBvTFX+6nOh3UyDgILoVgmgVdvkz13Wz3M59+sl0FPPIYmnnb+ac+0OCBTPt2Om6Od9cKblv419NHkvAk46vJwKWxqofm22YHsvdIaQQ2/wgyGG3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAxffUKF/sWX8pscCe4DeFmF58fGL0MkV9sloVvnjyg=;
 b=canBnf+bOd+mLiObqT+hXSMsHovcv9a7BLuefU3qmcIuIVeauaJND3O0+KDjGONBNsJi/dEC/ykosWzCrKMIYzPa93CiPf73mVLy5BoipHtmUM+sY7Nj+i6cazCbJH4UWzW6u/Laa73i2lAQqu71njaLeyf/Q5hMh9H6R9Yok432TXb09HjwyTcZ1BC0/X+K9bPh2IMDfcSWxwPDbCEJXSerTbmth61zzt+VmqhkBEjUkd4vUgm5ls9AXJwt0TC+eXgImSzz6uXiWNLesR+UhuW6iv4GVC1460Yafi0Cr6OSuQujZC6QpbxzGvqfYFYYZGn9hR38lznGq0fa+AMK6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB4330.apcprd02.prod.outlook.com (2603:1096:0:3::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Fri, 12 Nov 2021 02:08:43 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::7e:59ef:bec3:9988]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::7e:59ef:bec3:9988%7]) with mapi id 15.20.4669.016; Fri, 12 Nov 2021
 02:08:43 +0000
Subject: Re: [PATCH 2/2] erofs: add sysfs node to control sync decompression
 strategy
To: kernel test robot <lkp@intel.com>, linux-erofs@lists.ozlabs.org
References: <20211109025445.12427-2-huangjianan@oppo.com>
 <202111120433.A7XxZNvu-lkp@intel.com>
Message-ID: <b8b71e6c-fbfd-4989-a1e2-15c9ed53f46e@oppo.com>
Date: Fri, 12 Nov 2021 10:08:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <202111120433.A7XxZNvu-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR04CA0066.apcprd04.prod.outlook.com
 (2603:1096:202:14::34) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
Received: from [10.118.7.229] (58.252.5.73) by
 HK2PR04CA0066.apcprd04.prod.outlook.com (2603:1096:202:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Fri, 12 Nov 2021 02:08:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b86b45a4-749e-4863-bfb7-08d9a58159e4
X-MS-TrafficTypeDiagnostic: SG2PR02MB4330:
X-Microsoft-Antispam-PRVS: <SG2PR02MB433079E3016F4C684EA59F03C3959@SG2PR02MB4330.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sKJfzuapXqoNbFrFuDGO8d4WuvvbV8LYQALkVHzaJm6SqUXMGMB+oGDaPdzPF4OYLcOF4Mq2uVCt6/eut91JZ3ZS/4Iye+D8g9D2c1ltFsndwNPNUS6GTNsu2XniuUznQczVUsIULbs2Fc+Z9M1Nuk8YeQJlb0BtcER7JMMt7pN6wOAXVGlFedKepetnb9MppW0RCGxhVVJWc7vR07w/sbA9kdfLXUWLeFvQAp9vTon6dH1/Qhl/JehKE9HcMlPt0SqY8cXr+iOfD/tMLIYoiG3FMsicKoSAabZO93+NE8mTCeTufmm+soinuexVcIK06QZ/ttPHEqlGbzY4WRs7BsV5WW6Ze48Y1GqPWlh90o+zmb9prr97IX/OhdxZLjSFZx2UYPz613rCNyXdO6u1rcAfxn0ZatFA07qHm7FqfFFxVUjJ8O49l963m46noxtVmxU5C9zMx3QnRA4Dnoso1om2LSXKu2MfqQnNj0o4NFA7UGqiet5blLej3Rd/bOQHBlH47Fa1WcFbmhbrATpfkFUqNMUnBjECf2Dg5zT2ueyjcGzF8UAy5bTc9uU/CWidbWwmGBw+Bxl2Hs0CgAwJInmCagzj8KmSaVJC+y0nkb4RHa8cGWcC6ui8yLrK4sQyFqQvUiJw525y1wN10tT6AV9xppNyzWvRwe/EekQ9yJ4qsmh6dCxl3dFcg/buz27pK6j3RvG3Lu9en4nDWmbVgLjOvdTh/KOswgpagRRWTMp7g4s6iwJYGPKJ/mVCRvsx3NWFeCHVqzniyV+mEHcDAQG/EM/wzdLuGzjTxKyaYJIfUdbW1y/0p0K0//fCL/AnaFHwdYU7NJQN/NQuwokQv51vp/QYMIi4uZtQV1tBqA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8936002)(316002)(186003)(16576012)(8676002)(66946007)(52116002)(38350700002)(26005)(31686004)(66556008)(66476007)(956004)(6486002)(2616005)(86362001)(45080400002)(966005)(4326008)(508600001)(4001150100001)(36756003)(2906002)(31696002)(38100700002)(5660300002)(11606007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWt3ejd1bHdMY3ZGclpTTnY1RnE3R1VVVjBOc0x2NSs5N0sySTdpbkJzb2Fj?=
 =?utf-8?B?NVk3Vi80WCtKa0tkS0cwVzFQWWtIYkF3bldScnZFNVhLa29XdEVPcU94b2JX?=
 =?utf-8?B?VGJGK3M4QnUzTGpCdmpNSFY3UGRZZUlGQ3ZFTUpwV1ZOdlRLWDFaM0NBcFdO?=
 =?utf-8?B?emdlMVpPRnk0THhjNEhyMWQzVVBTSjc3VGx3YS9rUmh2WTRiNk9JMUZMR2xS?=
 =?utf-8?B?N0FkOEplOVZUbXlIeS9mYnppaGM0U2wvM21LWGpZLzk0MmtBUCsxc2V1VXZZ?=
 =?utf-8?B?UGFRTFdUc3ZHT3F1Qlc2ODdQWGhHdld3ZWRqR3RuT04zYmJHTXVpWTBEbVds?=
 =?utf-8?B?aDBkQXQ2ME8wZG5saWxRcDRhKzdGSktwUk4rQlRKRzZSRGpKdnBEd2c1cTkw?=
 =?utf-8?B?aC9YaGZ3WFNXQmtmVHdwVE1sVXV1MkRKU0FYQ2liZ3RuV0QrbDRxa2JiRmts?=
 =?utf-8?B?N2FSSmFOL0M4cENyeGlwZHo0dS80YzVrYUdLNjdKUWp5SHUydnd1d3BOSjVs?=
 =?utf-8?B?TlYxcHk5dE1hcWpUV0VhTEVvbVo4bTFKUnBqZXJPbnBETkdOSmZMMFhVczB4?=
 =?utf-8?B?M3cxWHA5Z3VHM2dMVXQxM3Azb08yNGg1a3NVSHoyZ2xFZ1JUeGUzM1FpUTdY?=
 =?utf-8?B?b3BZK016aExpTzdCOHhVMTkySVRCeEJqcGk4dTNMZ3BOUDVjWGVaT1JHaGlM?=
 =?utf-8?B?WFFpRzAvSG5UY2Z1c20rSWQwWm1BbnVuSVYycjllU0E3MmdlR04rTXdGODFV?=
 =?utf-8?B?czB6aUNjNmJFRWFhc1NJTEVCNXBRMUdqRmJPb2dXaGJtakdyNDBVVTFTalZ5?=
 =?utf-8?B?WDI3d3pCTzFwZ25ZR3NSeFZjY0RVcW9HS0s0OUdxZUFzQ3FUTGhGc3J2aTUy?=
 =?utf-8?B?TXZ1OGl0cUZVTUZEdlJnRmdGUVV1ZEpYTWhZSEpmU0RRTmh2TC9Ra3A2Rk9C?=
 =?utf-8?B?ZUVwZWlRNGt1VFJXM3NPbVdoQVI5Snkyb2g5R2Fhd1pROGI3NTZqU3VGZDBY?=
 =?utf-8?B?ZC9wTUhscGVObVRUVWsyMHpXT0t6NjJVQW5GR0FjVE1ZbkM2U3AwVHJUTzVL?=
 =?utf-8?B?Y0pFdEdhVlpTUHpNMFNJTXlIUGc4TE0waVEzRkJkaTlCRnJScnp4RlVoY2dy?=
 =?utf-8?B?YUFaV2pXVnQ3WkVORk9YdEhnMjBFOUNYVE16ZXcyQVBRWnpZVFcrTktKbys1?=
 =?utf-8?B?bVpkcEh1Q3pXQkZ6TGJjbnNQNXU0SkRvSUNyTEJ5TzhEVENtS2xrWUVrZ296?=
 =?utf-8?B?Q3E1czg3SFNMaldvZjl0dDhNWGQyYlhoTUpseWc2SHdTMEZ4NzBZeVUvSFZU?=
 =?utf-8?B?Wis5RXlibENoUnJZMi9uZ1p6RUlnM1FyYW55ZUduYjBjZWdCcmdKYXJiYWxt?=
 =?utf-8?B?S2JUdVRKSWtSZmxwQnVoa2F2U3JOQ28rWVhLbmJCRjNwRS8vZ3JuSFJJek1M?=
 =?utf-8?B?VjZQeDhUQ3p2ais4bmNIVzhGM1VLejgzajJJZjV0cEFxOHVjUDRFQy8yTnBs?=
 =?utf-8?B?VVB5UDJQRnNNZm1ZQll3OXZ2cUovVkZLWHB6OWxmN2w2ZVZoZG80TUhPM0Ev?=
 =?utf-8?B?OWdsajNYQ2kvZmhFaEFveGMxQkVEcW9PeG9Ib3JtRmprRUJlUm5nUUtGa2RQ?=
 =?utf-8?B?SlF3NDdZYU9Bd3JzOHpZNExDQzIzajVWdC84Y3VTNkJ0SGNmY200K21UTnpQ?=
 =?utf-8?B?dXRNMjY3ZWs4WFhnRXpPS3VaUmZLUmhxRVQrUXQ2VlpKZ3JxYUpGN0R3R2hj?=
 =?utf-8?B?cmlIMEtCbjV6eXRXVUllRjZPSGVudmd2SXZ1RWpnSG9vZUZUWHZjK0ExbFp1?=
 =?utf-8?B?YXVWdUsvRmh5d0pkaDhyaStJWXpsYXNjZXRkdGI4bEVZaXUraWx2YThYNnRx?=
 =?utf-8?B?bUNEMGJhSmVyQjJ1NEQ0QVZhZlJMcXo4eEh3TTdDcHJJbDVXMjhGcXRucmVx?=
 =?utf-8?B?YUhtcDc1Y1hiUFdoOTVaU3RacVNvaGpaUmxtem5naTViR3dzZ0plM3BZeWJw?=
 =?utf-8?B?REZ1V21wamxxcm1sbDdXSGhIb2g1eUtTZTZseDhCOS9ETWFPNHE4RlBSaE8r?=
 =?utf-8?B?c3BJbWhSbjdLdGhIbUdqaXdJVE1uZ0lkckMxS0MxcW9MZU1HQlpiYlAwYXda?=
 =?utf-8?B?MXpoUXR4bUdMdlE4L1B2Z3dhNTBxRFFyTWlKTldOT2hlNElNSXNHZWxqTnM5?=
 =?utf-8?Q?GoARg0Ws949o4IDRoLU2oqQ=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b86b45a4-749e-4863-bfb7-08d9a58159e4
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 02:08:43.0621 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8buHhN2Rp6hhK3yVvhRWhcEWsZ5z6twTQZl2c/0mQvrmE6b2KL/31CHIziBCl/QuUSIRUseWRCW7xHHIRjX7vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB4330
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
Cc: zhangshiming@oppo.com, kbuild-all@lists.01.org,
 linux-kernel@vger.kernel.org, yh@oppo.com, guanyuwei@oppo.com,
 guoweichao@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

在 2021/11/12 4:17, kernel test robot 写道:
> Hi Huang,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on xiang-erofs/dev-test]
> [also build test ERROR on next-20211111]
> [cannot apply to v5.15]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit-scm.com%2Fdocs%2Fgit-format-patch&amp;data=04%7C01%7Chuangjianan%40oppo.com%7C0d3d672ac3e94a90cf9108d9a5505aae%7Cf1905eb1c35341c5951662b4a54b5ee6%7C0%7C0%7C637722589678393057%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=OVZ%2BPtlKYw1zTA3lxF2mFAqcHDs6FjweHQpTpS%2B6uog%3D&amp;reserved=0]
>
> url:    https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2F0day-ci%2Flinux%2Fcommits%2FHuang-Jianan%2Ferofs-add-sysfs-interface%2F20211109-105542&amp;data=04%7C01%7Chuangjianan%40oppo.com%7C0d3d672ac3e94a90cf9108d9a5505aae%7Cf1905eb1c35341c5951662b4a54b5ee6%7C0%7C0%7C637722589678403052%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=vvNfYf7RfWT813%2FG%2FOUvTPLOyYqlw1FXQZXjPuqoqsk%3D&amp;reserved=0
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
> config: xtensa-buildonly-randconfig-r004-20211111 (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fraw.githubusercontent.com%2Fintel%2Flkp-tests%2Fmaster%2Fsbin%2Fmake.cross&amp;data=04%7C01%7Chuangjianan%40oppo.com%7C0d3d672ac3e94a90cf9108d9a5505aae%7Cf1905eb1c35341c5951662b4a54b5ee6%7C0%7C0%7C637722589678403052%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=SIkgxAB9wqCI7O0OjvYinNEpFtSD7vUO2YX%2FwQFC480%3D&amp;reserved=0 -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2F0day-ci%2Flinux%2Fcommit%2Fd6bf9edf69e87ee0a9795421ff2e1a9b69a29ce8&amp;data=04%7C01%7Chuangjianan%40oppo.com%7C0d3d672ac3e94a90cf9108d9a5505aae%7Cf1905eb1c35341c5951662b4a54b5ee6%7C0%7C0%7C637722589678403052%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2BHaZRNBm3bV0VbSMU0vlz6pokoI3tA8kNpVxCGF1wtc%3D&amp;reserved=0
>          git remote add linux-review https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2F0day-ci%2Flinux&amp;data=04%7C01%7Chuangjianan%40oppo.com%7C0d3d672ac3e94a90cf9108d9a5505aae%7Cf1905eb1c35341c5951662b4a54b5ee6%7C0%7C0%7C637722589678403052%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ICXqRmM2WczvCZQYR9hBUVQddexNDPdhSmr80YLCueY%3D&amp;reserved=0
>          git fetch --no-tags linux-review Huang-Jianan/erofs-add-sysfs-interface/20211109-105542
>          git checkout d6bf9edf69e87ee0a9795421ff2e1a9b69a29ce8
>          # save the attached .config to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     In file included from <command-line>:
>>> include/linux/compiler_types.h:140:41: error: 'struct erofs_mount_opts' has no member named 'readahead_sync_decompress'
This problem has been fixed by adding macros in v2.
I will resend a final version of the patch in a clean chain later. 😁

Thanks,
Jianan
>       140 | #define __compiler_offsetof(a, b)       __builtin_offsetof(a, b)
>           |                                         ^~~~~~~~~~~~~~~~~~
>     include/linux/stddef.h:17:33: note: in expansion of macro '__compiler_offsetof'
>        17 | #define offsetof(TYPE, MEMBER)  __compiler_offsetof(TYPE, MEMBER)
>           |                                 ^~~~~~~~~~~~~~~~~~~
>     fs/erofs/sysfs.c:42:19: note: in expansion of macro 'offsetof'
>        42 |         .offset = offsetof(struct _struct, _name),\
>           |                   ^~~~~~~~
>     fs/erofs/sysfs.c:46:9: note: in expansion of macro 'EROFS_ATTR_OFFSET'
>        46 |         EROFS_ATTR_OFFSET(_name, 0644, _id, _struct)
>           |         ^~~~~~~~~~~~~~~~~
>     fs/erofs/sysfs.c:55:9: note: in expansion of macro 'EROFS_RW_ATTR'
>        55 |         EROFS_RW_ATTR(_name, pointer_bool, _struct)
>           |         ^~~~~~~~~~~~~
>     fs/erofs/sysfs.c:59:1: note: in expansion of macro 'EROFS_RW_ATTR_BOOL'
>        59 | EROFS_RW_ATTR_BOOL(readahead_sync_decompress, erofs_mount_opts);
>           | ^~~~~~~~~~~~~~~~~~
>
>
> vim +140 include/linux/compiler_types.h
>
> 71391bdd2e9aab Xiaozhou Liu 2018-12-14  139
> 71391bdd2e9aab Xiaozhou Liu 2018-12-14 @140  #define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
> 71391bdd2e9aab Xiaozhou Liu 2018-12-14  141
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://apc01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.01.org%2Fhyperkitty%2Flist%2Fkbuild-all%40lists.01.org&amp;data=04%7C01%7Chuangjianan%40oppo.com%7C0d3d672ac3e94a90cf9108d9a5505aae%7Cf1905eb1c35341c5951662b4a54b5ee6%7C0%7C0%7C637722589678403052%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=I8XIGfml9qKANF9lYjvZ1eRcBGmbE%2BPDSsaajTOgfXo%3D&amp;reserved=0

