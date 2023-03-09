Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249976B1C27
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 08:16:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PXL7d5fQhz3cL1
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Mar 2023 18:15:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=TgwWuLNd;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feae::713; helo=apc01-psa-obe.outbound.protection.outlook.com; envelope-from=frank.li@vivo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=TgwWuLNd;
	dkim-atps=neutral
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20713.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::713])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PXL7S3YVfz3bT5
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Mar 2023 18:15:46 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfvT2q2RA0M12t5QSWLhHZIgDDbS8TeVxwSjo2eUtV50supOkn1tHyNDQrquxzPRFsbAZmvswMdfcRpxDEk69so5eVWfBsr4WocaZ+qSiLiBzVwMDyrWxO5ZQBOfVP/7QwK/sorr9G9STXY0pR9D8Lk3JfcLVahxVwQpUj80i79ozcm8RMGjv32NHrZX2hgGyfkYUtQC1+2YprJDfHz++x2DuzyqcoQG7smWoVA7HoOr+jaVfEJ9Sszw+rxx7uZOSmk8JfxmyYeWAXOV1P9JVfqzMWWZ0Tm9loBGvcNnhMqpd7dL8V4D7PGaaxKiCB7fvrekjEnvrZPckFfVe9empw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IQu8EqOHGbcsHzwIkz7+lTN9rhRSLYrxwBeIZoCfOk=;
 b=TgevHfCNn+ylwxkdnikBlZe2YxVdw0vcxQkoHb6nleX1GNEjrGWQ8YcmKAjqPPAS0oPOV3Lirs4awt1Yr5CPEIZ5pvE7X9G3IzwmyRhFF9AbpO+VPzD2WZH0U9AHyIRa097enfHBdSGh0NTnwFhzTF8HvTiuU4wlDxwBJLuC1EjnO/r/KQYhThHpqy5wqCy3IzGzMupIBafHKgrVzkVTVB2YzCNgDuQn2sWoxpTLk9JSj+G840IK5Y3tc4P8E0se9K94AvqfUfpW6b2qhosCk0CBO9wigxrAjY/8ntIJfVRJmayEre+iy4bb2i+kZqMOLrJQToEqUqxH0IpgdhgEBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IQu8EqOHGbcsHzwIkz7+lTN9rhRSLYrxwBeIZoCfOk=;
 b=TgwWuLNdz72q3skX5XDfzaBIjLNAWTwn/2AzZFW8/kGTvOh5DP8FrSDAI1DFfN2vXvRUvnBZh4BHLv1qWTaw8hLhCSgxJhOFoWt0RLS0b/48VmZaZLe/fQA8YcmSVoorJdVY9jdAthiMk6jXaSogHUcEO4X8nBizrJSkVRRm9KA7yKwW6yfz0tnhdK6YQOcYkVe2FanXSZsxH5mgBe6UF9xGSbgpWmLOi6LE57O2OMpEj0f6rBaXpN4fJMQmmwyAX+Syg2v2EPXr2KwJf/0/D+JSVEt4i1SVCT8LKp0DQbfYwKuYlvX8iHtSYtoqDk2FXbsVK2qSEJ2/+Src+/3B1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com (2603:1096:400:1f5::6)
 by TYZPR06MB4045.apcprd06.prod.outlook.com (2603:1096:400:21::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 07:15:25 +0000
Received: from TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190]) by TYZPR06MB5275.apcprd06.prod.outlook.com
 ([fe80::a2c6:4a08:7779:5190%2]) with mapi id 15.20.6156.028; Thu, 9 Mar 2023
 07:15:25 +0000
From: Yangtao Li <frank.li@vivo.com>
To: zbestahu@gmail.com
Subject: Re: erofs: use wrapper i_blocksize() in erofs_file_read_iter()
Date: Thu,  9 Mar 2023 15:15:15 +0800
Message-Id: <20230309071515.25675-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230306075527.1338-1-zbestahu@gmail.com>
References: <20230306075527.1338-1-zbestahu@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To TYZPR06MB5275.apcprd06.prod.outlook.com
 (2603:1096:400:1f5::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5275:EE_|TYZPR06MB4045:EE_
X-MS-Office365-Filtering-Correlation-Id: 567446d0-892b-4f6b-87af-08db206e0db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	+xe9oUB9RnewoMzM6t+1iA+PZrPuDSJkXvZNGnIq3Un406yC/o9b1TqicYsm3tzvLNOu1FovJwLXYYmxMVyBXBZZ3i0vZop4oxGAiDBSJIOInmhNst3MnjFKLNFk9vB0+jPIjH8BkDyHpMetwok+6zsMPxmbzZ1mOkRak/MPdkrQrSh5+1I7AL4SgsK+F5/5hDm57LMAO6kDMBpirTe5IT6/2IgvfS9uCyYjyYtC1QKtFPPpQDxLE+qDl9WvUaRofxI9zGTyHCiOaRONT06y3NIMzhiaw7g7Tv3ITd7RPWzv1SrAUnWonIVKp+rW1jlo9DG81HhF6gW9zEGXf3nj/YSHgVIkY3Q8uSHZFU/O6UobhHM1BSZ/7u4oqxrVqLDh5R/19M0bCIZRzu/v1vOwNwBIpd8kRlTbXkYg4ly+vl/gYiEOmZ32moqckgACf+axJtUG/QMhcLVd226bgnCZEnGF5ldgdKSEmxzSPRp1xaIDTM7rvcFZ7QuxHS2P6Dy5+NQTVJ31bKG1hHmdSi2mzKT6uSfx0k2HERi2RpWF2TtD1+lgb3so0U86K6jrG6gzQLJMmYqDmG6aAdSNKfLLPMoFnHoJMnnHioy1re6h87JJV7wxipuxczO+rIRaj0i6Yu5u4lF06OP/UhgW5SravEY6oplNw6GBOFDEJHyqLQcXsws3xPhJ1ZCflvB2eGlzA85SN55+Oq5Vw5tsiqtlAQ==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5275.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199018)(2906002)(83380400001)(36756003)(41300700001)(5660300002)(4744005)(8936002)(66476007)(66556008)(66946007)(8676002)(478600001)(86362001)(4326008)(6916009)(38350700002)(316002)(38100700002)(186003)(6512007)(6506007)(2616005)(1076003)(52116002)(6666004)(26005)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?+rRHj+iNLS55/LQp9yDNNi07+jmkPck7VyZkZOE460QrA/f27E8/5Yy2FL80?=
 =?us-ascii?Q?qne603S1lkScLXJcQ2MJhU31yC9PmSTw24+zqbTggquopLkVsKe2nNUV/LQD?=
 =?us-ascii?Q?ukHsR890r8edVUceiVjr18c9QlBzfepiwztgqzdW87GqFMQj13b7PHIyo3th?=
 =?us-ascii?Q?YMRa79h6/C2RLljPNPksqPk+KUwuN9fc5V6DjsJL22Dfn+uVzwvIzRSK9hDu?=
 =?us-ascii?Q?5WLFuXhaVU8nk2dTj1+wGfhCFis4pgfgOVUag4nIME5slr8rgCaSTBj36wJp?=
 =?us-ascii?Q?mAFjsiiIDqY0X0dwz4/NKKA9rvJNA1OE2tpkmYcIMmjmuPGLhgsoA57uPs8A?=
 =?us-ascii?Q?XTAhmdpYzcGw8V8gGvwYLw/30O1Chic5bEN5p1IYD5s7RJg4l9DQZfwfSu4R?=
 =?us-ascii?Q?TNieJywzBTtQpUqMFNon0Ht0YXZ9tsV6LBaZvJf6Z+8jaM24HmdyqQpnUvVw?=
 =?us-ascii?Q?M9HbDnCGHvAV8ZJvzxZHuTjRE3KCVBpfxaiGCBGQoRLI8wuOX8ANph6rGk8G?=
 =?us-ascii?Q?kVwgpY2jxwKYpkl8R+2di4kCp68rsIH9DI1UMAqGjUl0RiFvfWrRlZOKsgBd?=
 =?us-ascii?Q?pyhNwd4cb8aN7fQ4/FVVniuoCbUwUbAZULigQlHheHKg1jjxElIKd+3jRut9?=
 =?us-ascii?Q?enOesCWrqTSEK4ALcSaHYGLAgyv1j/XIbXSbxc5iXVX/5Om4kkdFINgUc7Hf?=
 =?us-ascii?Q?M3HCc8peJ4jM2/ZM9tCeDb6k10oTr2cxN/z5ruIf1i5heTaTjd+a1WgQwRPj?=
 =?us-ascii?Q?1HDgDBuVChanGpfOM4Im9RO9BvIv++uRRFy7R/Xfg/DrV2+LdndsWrIX4wuH?=
 =?us-ascii?Q?OZVh2CJ2Z+4Z2Vpvkh92IPu32LQEMrweDT5ehWnaz2sQoIVQq7GwaUQkzL2p?=
 =?us-ascii?Q?Z/r6bIgSwK9wJihxxcSqk8ebodm1qLxMSrJc3GBIa4VQedQeOKm42C9zSLH8?=
 =?us-ascii?Q?GfQ2WxzwXv58IjXx9trGeZpuJLVbTWrTnRbTZEtjzPHFPZAfTyBji/U2o3hP?=
 =?us-ascii?Q?+dQkv+Uw1LTcYnxUdiXqpRKqBUGIom/0SHb1/r81SjVDf0+70EsizoSCR3ri?=
 =?us-ascii?Q?5OuSobI6j40Gl0IIZBZ93P4mkjxJQR23ufBWYsP1V7CR3u0AlX85gpY/6v64?=
 =?us-ascii?Q?qFDE+1omxZ+9UyoTQBuRic9afVlpcQXXgSeLTOCMV1xuF/XCuIOUbC0qkxjY?=
 =?us-ascii?Q?eiewTOgU6tMJK1d++W6sWXlXnXbJvGgnR7OLHc6d5OXsrQHnx9yF0BYo1szX?=
 =?us-ascii?Q?TJUAgghpQhyOclHbESUZvZL/B1pgECpMXgu/RlsIyNdT3U8WKMJ356Sx7WKa?=
 =?us-ascii?Q?lX0/2KHZoTsq3grHvzZDKypoaMcR/zoMkPU0AncwgXm6HQN/UMyS6lCjq2II?=
 =?us-ascii?Q?LG6CO3U84+XHdYmNRxf1Xhd7jvQGDrmk7f9wEtihI7GVwF5CSYN1I7fH8erY?=
 =?us-ascii?Q?n3Yt8/mLZyECKwbSBogVvhIKJ3oKlza4pcxFCMSfXYSGIHPo62S0ehvUYLUg?=
 =?us-ascii?Q?afxYDfhiPoqWicxTv33jQVQuLmPQiwuTqEppQ1+g5KXF3vwL8QfXYUeWyTTZ?=
 =?us-ascii?Q?5NAG39A8ZxUvfHujYMjAsaNTW5dx/R0qAKijtkGy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 567446d0-892b-4f6b-87af-08db206e0db1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5275.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 07:15:25.5519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0WH6TVaFZu8ONBzfU7ndkj3gqzqNW6e6dSDSjWNIKruNi0ZdrhJjdOq0HkOSbHvtYgvmgYHj2eSyea1cty2Rlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4045
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

> @@ -380,7 +380,7 @@ static ssize_t erofs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> 		if (bdev)
> 			blksize_mask = bdev_logical_block_size(bdev) - 1;
> 		else
> -			blksize_mask = (1 << inode->i_blkbits) - 1;
> +			blksize_mask = i_blocksize(inode) - 1;

Since the mask is to be obtained here, is it more appropriate to use GENMASK(inode->i_blkbits - 1, 0)?

Thx,
Yangtao
