Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0759044A79D
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 08:30:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpKQT4PzMz2yPW
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 18:30:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1636443041;
	bh=r/hj6X4P9Wa89nsz0roIx6mkjgd5Eg5m5BqyHaFGDOk=;
	h=Subject:To:References:Date:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=hJekLegLsztuwQL7LsTkVR4H70PcY8H43oG0lSM1XA0wtWXdyzBH+OkaLmVhcjygs
	 L+6DBXSLKw7881eVR+0pwlVyu6tN0XV3tMuVRXHb8wWo9d8OwTHhE/FxX/VkiN37Ta
	 BykFYMk+oFMJBnslhS8R7oRXa1lJhjun2A6kDPsjq3/8u8l0BMiv/icW2pNhFCDMBu
	 VyA6EOS7/MiuW3B7V0APsF/eQ9aYZrYxXnQMCxPCbuD5HH6ngaaoM7/nS2HZLn09ZC
	 aKvECOH+CWmNGpSUzzDyP7dGjLCJlbGGPoE7HnbQvlh4OvL07D1/zknSG9ocBP5HT0
	 v05hLlnPLVeWA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=oppo.com (client-ip=40.107.130.47;
 helo=apc01-hk2-obe.outbound.protection.outlook.com;
 envelope-from=huangjianan@oppo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=oppo.com header.i=@oppo.com header.a=rsa-sha256
 header.s=selector1 header.b=tzoAUbl+; 
 dkim-atps=neutral
Received: from APC01-HK2-obe.outbound.protection.outlook.com
 (mail-eopbgr1300047.outbound.protection.outlook.com [40.107.130.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HpKQK2HQYz2xtZ
 for <linux-erofs@lists.ozlabs.org>; Tue,  9 Nov 2021 18:30:31 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkRSi4BcBZowoY6fQB+ZqW1yuCx65gU6JGxnvc2F/yc5NMcw8gcQMPPUoq3Q67XGVLwEER9ahvN7Ovayv9/QpnO2sWSNbt31pByDEeXhv3KEI6RH0jAu9PwezgUBqzt7jMeTwsLgamZYaulCwe2lypgwhKL6rxS8IdQkH8vzz87hOR9VRfC4FPGCIQdgHVyvBDULtBZT43asgx6DmfOZjUe2IYHQI+u0VPtmnpVFJKKTSQTd9ZvwYUw8rvDPfZAXZY4Yq7JsOnnX/kvgH/yJY4GlpLvA9jccJF1JW6tIRkNRkPD14Ji/hyGxfP99y9BxyqTGGWAzffvps7TLvhpUCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/hj6X4P9Wa89nsz0roIx6mkjgd5Eg5m5BqyHaFGDOk=;
 b=bjFblSEbgWrQtQvbybCo/gpHZBlsiDcqkIcpJjbxjRkwyssBPwMAUABLFyXe5Oe69kDDzyYdjw5quBz48RstIUp2n2j1ZN2Jj+AD3fp5R5AaD6jqPVTU+voCGXbNeGOFf7Q0ynyOwERTxtrxzqOeCQz8m4QUHNS5tq/U4HmLBA0x/zjLqPHjUWh37yAugHi1fUG+FPUop/+EMOYBL6bBhp56Fd6vdtTQtTPBoNdQGXmqTcZ50bfVFl333t/v8cdVCyihaKIFHc4Cdmu339YNygfTfXk8LfERVoWrwxprH8eGvtUt3VYCC+g6hhBa0c80ig44Eu6L3UK4ZV/tgvluhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
Authentication-Results: oppo.com; dkim=none (message not signed)
 header.d=none;oppo.com; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2557.apcprd02.prod.outlook.com (2603:1096:3:26::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.10; Tue, 9 Nov 2021 07:30:13 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::7e:59ef:bec3:9988]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::7e:59ef:bec3:9988%7]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 07:30:13 +0000
Subject: Re: [PATCH 1/2] erofs: add sysfs interface
To: Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20211109025445.12427-1-huangjianan@oppo.com>
 <YYnmmla6xh5Y4d30@B-P7TQMD6M-0146.local>
Message-ID: <8ac546a2-25c9-a694-a82d-91984c826436@oppo.com>
Date: Tue, 9 Nov 2021 15:29:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YYnmmla6xh5Y4d30@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR02CA0187.apcprd02.prod.outlook.com
 (2603:1096:201:21::23) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
Received: from [10.118.7.229] (58.252.5.73) by
 HK2PR02CA0187.apcprd02.prod.outlook.com (2603:1096:201:21::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.10 via Frontend Transport; Tue, 9 Nov 2021 07:30:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a277261f-5a9e-4a4a-0be4-08d9a352c4a1
X-MS-TrafficTypeDiagnostic: SG2PR02MB2557:
X-Microsoft-Antispam-PRVS: <SG2PR02MB25572D34DC88E6EFE9D33A7DC3929@SG2PR02MB2557.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hzPCIBKRkRbBlL+OZ8hbhk9jOl/3oWWXHacsHQiFUhbjfNfXiPNKj9QUnw7jLMuc4P7gQxbYcRMzHYK95ZDHGYe5Qck0lhqpBApdY6z2EfdfNbsPP17kCXweKlAJOdNMGBQkUT31NGEhyZWT4O5ab1u4EvEZ8sVxq/vM6ZrDxkl6GXbLrSHHLWm4ekQXZpJTEAu0h5qq31vJidhU1GLhzLj38Tt3X13oqLIYpF/YA6p7urHPJ8CV/IOPNItP72OUYoXfS6vWeqsEaFMcuzR+cXEYp1gw8Yqx4wtt1wk3e7iuBHZNw6CHuBnyiGwHVA24M82MQJE2fruu1Y0onmp4UVsff8JPPeblqLa2GF2c3W9W3vT2v1GIAvdTp7uCuZkLDQr0yRiiwPoBgM6C3fBOoW3sXlz5Pl6yntx1DYvRy6y4QFqsk+uNxAYc4banIgKpP9TtUCdMUkL5ZnOdLh/7QCvEYkYJ2fZoNxeMXpnXWZPahQ5TPTQlPkNx+TIvoTCgmP6hbm70ecDxn+njzyqGOFLnlMYt0NbaNL6e/nimVUd9m4Oq2ZeONNuN+UWy6T0zZgtdYWPJc3C4UFKBaImi2RPqJ54+eLVSln5V45nKB1wQVxqI8faf1qrK13s1oIJKmu9kJHl6Cs9HQ0zUOIgghtTbJZ0mU8+kL4+pCarPQy3MwzoglpNf+md4pMmQI75HpV2xFKLhyW/tyw+WrMccmrFIbseA3N6f1g8ZQi3ZbJCsUdc4mq0tAN0+PjvYjQnDL6Hk2otEVF0ywxAath+peyYuKUWQkHj+V4h2XJybzTE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SG2PR02MB4108.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38350700002)(186003)(26005)(6916009)(6666004)(956004)(2906002)(31686004)(16576012)(38100700002)(31696002)(107886003)(36756003)(4326008)(6486002)(508600001)(5660300002)(66556008)(66946007)(316002)(86362001)(4744005)(66476007)(52116002)(2616005)(8676002)(8936002)(11606007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3h0Qk1QUWdSdk9oWnl0ZXhBcGtJUEhYUFgxV0JwbzhiTlNqVXNDOFEvYW5H?=
 =?utf-8?B?S1lBbk5iM2RaUTdLQjlHVWNWN1hMc0p1L2V2L250R1ZyQ203b09PYlJzM1ZT?=
 =?utf-8?B?a0NDYUM4OTlnWU9reXJBQ3Q0b1dkYUtISER1YlJXQ1ZEMVAvTFZqQkRSZ0RM?=
 =?utf-8?B?S2dQV3A4Q2NiTjMwZ3dCU2xldXZyMW1VNFhqbnYySnQ1SVNyTnExaWdsKzFU?=
 =?utf-8?B?M0RYbnBNckUrVjNzVmZVSzZqRE93Z0lvU2d6VWFkbFhabkN2SXlPT0J5ekN0?=
 =?utf-8?B?bFZjVTlvcGhKVVZVRTNrRm5ydGhWb25kY01rWlhidDVnTW9xVnhIdWJKaDBa?=
 =?utf-8?B?cmpSenA1U2V4ODlqNXd1TXhOMkpsUXBET3NBZC9zc2VFT2ovb29RalVaVm42?=
 =?utf-8?B?Z05rM3ZJZG4yMjJKRlNLYm5PdVpBeGlVK0NVSVYzTUt2a01VOXNnMHB4Qmt2?=
 =?utf-8?B?VkgwVUdiTjRscHpCZk5TZ294dzhYd3Jwa2lKdXp3STVNNlM0QmFTUzQ1TTNV?=
 =?utf-8?B?NU9SUW1HRyt0NEZXZ0RwWFNITDFpUnhNTEFNb1hHcDhMSDdMUitvaDNPU1Qy?=
 =?utf-8?B?NGZKNDJ5Z2xBWWFGUW1qSU80TUFMVFllVkc1cXRjNWtmdDNacm8xTzNpb0R3?=
 =?utf-8?B?ZXBrN3BlaE9qemZscktYL1FVMmZSM3FWRHFHbFBGTmtlL1FSeGw1MnBRQW82?=
 =?utf-8?B?Q0NhZmdaNllYTzYxQWUvWXVXcFZLV3IyNWpmWmFQRHhIbUxzT0pJSGZLYWdj?=
 =?utf-8?B?SWQwQ3NhTk5BZzdXK0tNMk9LWDJGVDFJRERYUHppQ0VCTnlyZHNzRThFenRa?=
 =?utf-8?B?czhjRW9FblJwTzNibWgwVXlabFZWQ0RueW5HS0xnT1l4YjludHBTYm5TWWc2?=
 =?utf-8?B?TlJ4MXhUY2t4MXVTcjFqRjUwU1pwcnJjb01reCs4RVRtOWp0Y1JxY2V2Uzhr?=
 =?utf-8?B?VG8yNDlQcytWUzNRelZYZWcwVlpTQVZpNFljZFZRKzZUUHozMXRPRFZQbldq?=
 =?utf-8?B?cURYWmxiVFJrTHJpZEtLTUhQTnFWSkk5Zm1EMUk5NzloZHYvN0xvU1hZaktF?=
 =?utf-8?B?ekZMRWRLTnQzQXlqRm43cFI3amQ1SGM5VGx3UjVTWElXb3lyUlYwRzdRdy9T?=
 =?utf-8?B?Uis2NzlFVlpWc3c2TXZMbHE2UTlIRWhHVTYvMjNDZmtPZ0ZUNmYxT0FBQ1JZ?=
 =?utf-8?B?d2JKVTU0S08zWjd1cmxxMU0wdkZxekhIaEROa1VCREJja2FXbUVTaXFPMlVl?=
 =?utf-8?B?UGVZak5VT014MHp2WmE0dGhGckVFTGNieEVnQTQwYWpVRjlVa2l6dTJQTVUy?=
 =?utf-8?B?b1pQdkZwcVBRSk1rTjN5dWhkbTBoM1B2ZE9TcEl6Z29rOUk5MUZuTDg1cWx0?=
 =?utf-8?B?Q2hQMDBYc0VGMFNUS0djSXhUbWZ4MGNlWFozK2s4cVRHdGJOdmU3U1FPREta?=
 =?utf-8?B?NmRNOHRuczhQNjhWOXFiblBFcGV5ZzdOcWZQRWRCOW1oWjJTU0RPeDdNMDJD?=
 =?utf-8?B?bmU2NEsxUitPMUdFRVR4cVNXVHVEdEJjUTMzOXp3NlRWNlZjeWpxUHlkQVRT?=
 =?utf-8?B?bHVONkxDbC9DMmFNUlMrZjJSN0pwWW84WC9QMU1OM1dpS2NuZVdZSFhiVmtX?=
 =?utf-8?B?WWVHanRQZUZVbWxxN0VtdndXOEc0TGZITmZnNE5YblhmV25rVU9KVzk1T1lU?=
 =?utf-8?B?Z3dGbjRCV3dvVmVUWHR2aGdrZytONmR3RnYzOHNrWE1WVlhUeGg5NlFwOVBl?=
 =?utf-8?B?eENhZWFyS1FjM0pQUVB2a2JLMnJXb2FOMnZqTUZpb0xlMmhCRjVCTWN4d1g0?=
 =?utf-8?B?dlZKSDI4MmVvWGJMWnBpRUt6YnlmaWhiQ0l0L3p3Q05sMGc3SGsrQzBkMmZz?=
 =?utf-8?B?MzlKdHFSa3J3RFMrSjAwRGs2TFZ2NitQZjBzaGJnRGw1R3ZCWTdEa3NxeElX?=
 =?utf-8?B?dTJlb3ZnaCtYb05aT1Rza3ZsTjREREY1ZzdSWWVnTmc1cTNMbjZ4RHNSam5Q?=
 =?utf-8?B?MExjWWt0QjZxcGVuUkdWQ0ZvZVhoNkticUFUQmwvb2c3Wk44emd6VkhYY0Fw?=
 =?utf-8?B?bXhSR05NeERydkc3Z01Ma2ZTQVhQYXpPcmFjVVdKY1h2dDZRZE94NWZPQU9F?=
 =?utf-8?B?TDMvbUhBeGc0YS9GdysyamYraTU0STVjSzVQQUFhVW9mQ2VISWo5YSsxQ053?=
 =?utf-8?Q?sWezQbcnunFWUF8oQDLEmME=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a277261f-5a9e-4a4a-0be4-08d9a352c4a1
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 07:30:13.4408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 46cFX1FLdNHW6udlquDjOTh6+zpSDaydx8Dsqh/Yj82j6FkWJLb72q5ZC9+OP8IujRQohEKccvpSV026TK+lEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2557
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
Cc: zhangshiming@oppo.com, linux-kernel@vger.kernel.org, yh@oppo.com,
 guanyuwei@oppo.com, guoweichao@oppo.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

在 2021/11/9 11:10, Gao Xiang 写道:
> Hi Jianan,
>
> On Tue, Nov 09, 2021 at 10:54:44AM +0800, Huang Jianan via Linux-erofs wrote:
>
> You might need to add a "From:" tag here, otherwise, the author will
> show "Huang Jianan via Linux-erofs" due to your mailing server...
I have used --from, maybe I need to add on the patch manually ... 🙁
>> Add sysfs interface to configure erofs related parameters in the
>> future.
> s/in the future/Later/
Will be fixed.
>> Signed-off-by: Huang Jianan <huangjianan@oppo.com>
>> ---
>>   fs/erofs/Makefile   |   2 +-
>>   fs/erofs/internal.h |  10 ++
>>   fs/erofs/super.c    |  12 +++
>>   fs/erofs/sysfs.c    | 239 ++++++++++++++++++++++++++++++++++++++++++++
> At a quick glance, we might need to add sysfs API documentation
> as well:
> Documentation/ABI/testing/sysfs-fs-erofs
I will attach it in the next version.

Thanks,
Jianan
> Thanks,
> Gao Xiang
>

