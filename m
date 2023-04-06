Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6906D92EA
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 11:42:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Psc3N6ymqz3fGQ
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 19:42:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=fFeMxTVj;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feae::724; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=frank.li@vivo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=fFeMxTVj;
	dkim-atps=neutral
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20724.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::724])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Psc3D5t6Cz3cjB
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 19:41:59 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcCy3b3rxW+3PvLOo2NMBLCgVCzclOgkOKvtWABa5GsJEH20nu580A72xF3LEwqF1IZNhBbKKRg7CmCHIScMszkE9wt0EVZt+6sksUIAxJEAas3jnYB4M3kJHXHNT48Zx7v+uxwxzLaI/itM5LchBwSH2islpoDMngJziWSfHrQa5lGKDSQKliPsZSgFNF6dls2txc8Qd0HHAIoU1E726G1CsBYA+TFHyU899ooR1x6vORKuh7m0sa4+BjVJA3Yq2y7JPiwmgppNcQH51dPa5G8IlcxYyWOu3dCrR3jTyVOI/1XyIHkSwLpjMzN66slx/PXyEQID0ScLTajd1DfMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qg/FIXGbQfn1wiiz+PdQuOA0m8F8JP0zGij2BbYWW00=;
 b=PSOQGc6+gn7aM4scFuFeus2ixbOjgDdPWTfIbsTImNlpBK2QYGssdIkgslMjqLJVoxEQEjMo+QGx9Q0NHO9FpdJiS8VuG/zhly4cCEBTZqRPqH0KCr422yr3lzRK3rwgSUrpc/8ABL1M05KI+dWTD6kXub9hlA0sQt+GubHMZ+tnJGRjeznNHqPzuo2nBxlcGJCupJ2y1QCnNQxxMKMl/RLeq/Vp2nMw+mItxU5hGJ3ItW0SDpFrQY3lsC5gDqedIQq2KIahQekwhhIeX0SOt4wUSLVIcdeAuHpysXPYa/kEpF3AEa8G6Aog2Y8mqCvVW9GjbzR5lXleElzBtj9hZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qg/FIXGbQfn1wiiz+PdQuOA0m8F8JP0zGij2BbYWW00=;
 b=fFeMxTVj3yV9g/uhocytVlyuYZyCGGGQO5qW3GYqr3XHRTAmCLmz5d5MyEGqXRsAhvXMASMLwLFzMbTDlQxXeuzpy9HzLeQbLHNsvvs7lWe70mSMh1KflDEQ5nOAAXyaClEEfhRgVXGU1KoZ/P1uo6nAKWzPCf2spsTGVIAdS69oMe3cZUoeWXiEwKY+QXpvwspd0Gu+ZOUfxhnDKqkZSdUtysZHMCsCc2i5ws+NlB9FmK0Zw9bnEvTK4jGArGAIBf2W+kCJ+h5+HVzMMfF50BwvzVF0LiGjakHncRv1jyOcNagLbG4jKtqTECM34rrnI9alcb6ZrAASoxGSK5AA8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
 by SI2PR06MB4610.apcprd06.prod.outlook.com (2603:1096:4:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 09:41:36 +0000
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::16db:8a6e:6861:4bb]) by TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::16db:8a6e:6861:4bb%5]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 09:41:36 +0000
From: Yangtao Li <frank.li@vivo.com>
To: hsiangkao@linux.alibaba.com
Subject: Re: [PATCH 2/2] erofs: remove unnecessary kobject_del()
Date: Thu,  6 Apr 2023 17:41:28 +0800
Message-Id: <20230406094128.36587-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <028a1b56-72c9-75f6-fb68-1dc5181bf2e8@linux.alibaba.com>
References: <028a1b56-72c9-75f6-fb68-1dc5181bf2e8@linux.alibaba.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To TYZPR06MB5275.apcprd06.prod.outlook.com
 (2603:1096:400:1f5::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5275:EE_|SI2PR06MB4610:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df73d2e-f733-4f1f-4243-08db36831d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	slVYN17YPKyv4Js4kTktrlKO6oqBkeYKT28+iee1EbA4lhGniMtfWOX/kxPlcqR9A5Qlq1nPrneLCj7CbKi4ueYeJnOjquBgk0cukcCG1xg4FKrnNlfrOtlF9X2Ue2E1XpIQ3Fu9c+Sc+LNYbV3JwvNbIDPHe0VpBCkXSr3XAx8qOZzfveBS4krk+4iLSIH7uvJJ2OYbUgjUqIKZY8lMOwBZzgNCBob74TLAMSXSTC45SB7EQIGNVBXb/UXJQxcuSy9JfNMnrW8gi4ilvak70d4un/aD/GZfbHLbhocoWnlNfWQOwioeiAh2nKNa07pqa1BoYo2A5u0Kzq47Ghd6wZPUt5HMDeSVT9mEih/qqNG8m0YiwsfHESHPHirIyyIVH2YE5PxCOEj4VtcvGw37L4Dh5gUWnPJ4gkYb9bKZ2p9arumt1QZWJw2GrWEeYCTZAAI2rAUmmCrG5PUiHgtjXAe5zhqz9QZwA9WYXxxgbCzybxq1/oH+vQFJ4Am6mVPC9p+NNXiKCttvAafzH2EqEQCskoWgZmuXJ67TMmUqGJAIVspMP/NmE3Aph6dzwuNheM+ODDNGwydjDNJ4GSm7z2/2fvQBOozynAoNRUq1Ha8=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5275.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199021)(4326008)(36756003)(8676002)(316002)(66476007)(966005)(6916009)(6486002)(66556008)(66946007)(41300700001)(478600001)(6666004)(52116002)(8936002)(4744005)(2906002)(86362001)(5660300002)(2616005)(38350700002)(186003)(26005)(6506007)(1076003)(38100700002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?tgAa8Q7ZfribeyhC851VwSSO3umGNschdd3ceULEKdcRgy4K2k6/vUcuCOg1?=
 =?us-ascii?Q?WW0jAAdiS2Vnyb+j0uPNmUFBVen8zqGY9GJ8EYsXogrGVUvj1LSla6kIJ0cS?=
 =?us-ascii?Q?sPyGFyqRzmUzh2HsPyEXtCqf331qGBifBi2+aGaszvwdVXklie0iaB+EI7rr?=
 =?us-ascii?Q?5mm0OXsQ4cAVqtmHGuN/cdMljnyCDvxNcWLs5DrUB59JRmMYQ/8vDzllxqGt?=
 =?us-ascii?Q?K25q7Kp9GNsbs+QJoY1CUcLa4wJZMSa3GkY9C1/AhEKHv7aAB4BfgmJRirzy?=
 =?us-ascii?Q?mYDTh+5eKJ7TsvDYCk661PVX48Z65AaTPbgmFDlWlgnR9vpKhglEIpPTMs/w?=
 =?us-ascii?Q?hrR5S8rSA6aBfXNWacy2++ez5RPaSskZ8VVepJk73OChnuGJth/ao78aYlwD?=
 =?us-ascii?Q?f7SE1RRYBAK7DRz+xbLIiS2/z8PW9O8YHZCMuFsMNOAtbawjMzJpEMAx1ebB?=
 =?us-ascii?Q?Ql/MWthBBUeUOyEYGPchqpOYjE4JxVjXPZ/o39OZDuhX0QKvHn7sj5HnkW3w?=
 =?us-ascii?Q?Upo6iwlZXY7KtZ0sFU3/xzKvEICjorubFbMzselguJhohNMpTDVu6/biB00X?=
 =?us-ascii?Q?rNepZLN72sDZVmIfpfQ25r5tRfh6UTufNeGU8h4o39tnb5Q+haNsltq9VbFl?=
 =?us-ascii?Q?swGxCfKRHZGce9/CJ8mq/HdAmmIuBAUxoqSp4qCvQP5WGhjor5Eobb+Z926S?=
 =?us-ascii?Q?OcjW+fp6gTKpsBUsSyF8gavs8qWT2rUa9sTKF3mL7vQBxT5vAIq6rXTJAIaS?=
 =?us-ascii?Q?90Y7JP2asGV4/PYemTekdBGAZ8Kfz5lDaG/7E49Uts+9nvgWta0b2VHvoGjo?=
 =?us-ascii?Q?uptMvvf2zLRWG7Lcb3zAxQqz8l4rOPrfLJ3zeiL4lOrz+utRMxePSeWYzfKb?=
 =?us-ascii?Q?F43iwoyzbJLUiF2GUGz/s3JL/qXi8ncm+m6M84JOylXbpP5CMLt4jM+h9UDX?=
 =?us-ascii?Q?v7Qbas3I9TiD6orKl0OesS0RithWnQyzjT4z6O/XE4ShHcaYbiGPt3ZPuiW5?=
 =?us-ascii?Q?c5CX+a1ewyvY0cEGDd5Rcqo8kpqDO2/Txjtui7pfrj2+0UaKamkSG8h7KvEK?=
 =?us-ascii?Q?htCSg7bKJzZuS91OCC3WTHDLiVOl/WsNfN6vojiUSCGUHQx1wMLHlP17ywO/?=
 =?us-ascii?Q?0/rQmspY8j981jI2kd4z5MUK9KleyrhgkBRZI6VoiVt2GI1bnN6oem+fMXb3?=
 =?us-ascii?Q?mFmIEhDDI0wOxi9o3gHNAeYd7htblNfF05q7zn26mKKBNzFk00DmAHbOl740?=
 =?us-ascii?Q?5ccZzEdY1QXnCvL/SLuejzZrKpVFc7GtkLjbrvlQ2pZE78xhobNQCft0RJYg?=
 =?us-ascii?Q?9HeOR3b1iBkuczxinO84vQQhHzv0SCHUqtAAB8zRspVT3xr0gCE95gbRFIWc?=
 =?us-ascii?Q?X1WNhcBh2zBzaRNnmV4f++0xiCRs4v1z7n0qPfVDtmkTQILMLKAGqynTyx9Z?=
 =?us-ascii?Q?NVIAAz7557aS7oHau/3qXwqhFjiM7XfwPoxzD9D0KfOXcLNzeb9rGDkZQ+Vl?=
 =?us-ascii?Q?EFivXLoj3D5/3yCOVknwHzhEMkNIHRYrsSquozjdQK76OuxgmQ9ZjI4RnuCT?=
 =?us-ascii?Q?kI/eItVMMZQZYX6pEZ0riq7HQsfij6tEE/antH1p?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df73d2e-f733-4f1f-4243-08db36831d33
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5275.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 09:41:36.4241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sV1zCuIxQK7O1WqrEGP4Ayko/Put4UMd04Mc1c39sEXtAu4ouUSXnIX9jzZSjw3IQmWegWjOE2zNJKp/Lb1hkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4610
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
Cc: frank.li@vivo.com, linux-kernel@vger.kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

HI Gao Xiang,

> Would you mind taking a look at
> commit a942da24abc5 ("fs: erofs: add sanity check for kobject in erofs_unregister_sysfs")
>
> , which could be "git-blame"ed (I'd suggest looking into these
> blame first), and the related discussion was:
>
> https://lore.kernel.org/r/CAD-N9QXNx=p3-QoWzk6pCznF32CZy8kM3vvo8mamfZZ9CpUKdw@mail.gmail.com
> https://lore.kernel.org/r/20220315075152.63789-1-dzm91@hust.edu.cn

> TL;DR: I guess it could be fixed as below if kobject_del() could
> : be killed safely:
>
> 	if (sbi->s_kobj.state_in_sysfs) {
> 		kobject_put(&sbi->s_kobj);
> 		wait_for_completion(&sbi->s_kobj_unregister);
> 	}

Thanks for your review and detailed explanation.

MBR,
Yangtao
