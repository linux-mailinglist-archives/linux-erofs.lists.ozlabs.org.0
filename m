Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D02126D9898
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 15:51:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PsjZc5J9Vz3fR2
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 23:51:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=Fk3mllGr;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feab::70c; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=frank.li@vivo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=Fk3mllGr;
	dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2070c.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::70c])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PsjZR1g52z3fGQ
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 23:50:53 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdgbpFLcbBXUzb/U2V/wgtstFmdnA7JqfaI96W3UQNsjdLx1mblcVfhP83ZAMBbXp6KODeoDBvlxQDinFJ2zRkQ8RpPEFVlF68nnFohXTo3IElMo7d6yWt/f9ktGhcHS4/ZAOMppI+UKbmI9DOe1kXnYqM0p104JMsQynZtaFEGVsdf6jvoOs0VMjmvBVsfNT+SxZT60JbMWDnOewX5f6Ury/5Wo8d/F3xSHFvkjXp3jpfN5R24r3LEGfm0aoeuN8H2QnQnyiTovp/IKa6gKZLu3md0Kq3z2jCJFJFdPTAeEMW3EYfbbfwaEz3wkib801yTkTAQYbIj5MzfsUk1AgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9U/4LPYFC5AzWVMQlNbNI5nua33P5qNX04zW2fwoQ0=;
 b=JmOQCPQVQOeqMkWkzyrIRsqiZfS32YZdND14Iwzy5zQit4rgrstag1+hh2+ewPiRl2cHL8c81e69Cvj1+V1+0OgRl41P4oE5zp+9HPF9f4fW9MsMPdJIyxAi/TpZmLRHnSJTo8vaE+jRK8gA3BGG/GB/Wly0uBm+TLUnYxC/gLEJ8zdFMwqGIEJZApfD41KcMLvyu2X1p6PUotde1YLuKPGOwcpRJDK0I4NTlV+ewTc971NayuOyQxC3FRSU9uKTAztXBVwg4G+NsvUKEAvLPV2Jbg0B1QlMqI9tuBhMqlwgYtOX1KXHI5F8VU2BTtWqZ24+cnSukFEza4maGpDfDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9U/4LPYFC5AzWVMQlNbNI5nua33P5qNX04zW2fwoQ0=;
 b=Fk3mllGr81CzVAUKC0vZN/dn/sniCfd7eKivtuPueyCYkolRYW4QG2JoxMDV560JUIlmkMvjVrQotAHbiYRdaJbxtMyGOYrHN5fKaNKhhi8ugSSL0TJtXYPESKdXkvNf0Scke4I3zOdKThpo2jHRVKBosTW0MGAT5q8fhTkVwmWLAatLfrybG9TfZwj5pXI7pxC0hbF5tt5knXAQ5i6jfDsLDicwqwPusqOe+5j5lX+DnQbIoE3wo/UlSsymG5CtDvVgdumh+ZcCqUv/iKw5dZL0w2XjWF87pRhO0aXfshBR0NwBMV9t7ExS4WJNA8eOzK4wUtM8RjgJ9tTW81n/FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by PUZPR06MB6245.apcprd06.prod.outlook.com (2603:1096:301:11f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.37; Thu, 6 Apr
 2023 13:50:32 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 13:50:25 +0000
From: Yangtao Li <frank.li@vivo.com>
To: frank.li@vivo.com
Subject: Re: [PATCH 2/3] erofs: convert to use kobject_is_added()
Date: Thu,  6 Apr 2023 21:50:14 +0800
Message-Id: <20230406135014.75466-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230406120716.80980-1-frank.li@vivo.com>
References: <20230406120716.80980-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|PUZPR06MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: 85370b1a-e5a4-44ba-7ffc-08db36a5df64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	Wyvwam9eiOKKiwMM8ALRK/DDjJh0SiRA96tjGLIlkqaDj8bP7zd03wVQvNvzP7vwMNAHyrofgqBz+OHlzSYqAiDYYALlrHaSwxjcaBrn6THWm2x9qlzYCdK4uyvlqjE13Lecy7qWp7XADtLWIoWAPod2ARPykTnE3R922/ZqroMKx+3Chbw7zkc4OOFcy064czYwis5qL/OIY1lTJ/86O7Nyr+B+oDEK3m2FIEodfJoYCDc3w3+FCNDFsdCddaqARWYsbaaA0pUstyBKWCW68onDilJQn5CKHNFBgEqAmlDayDo6zH+lBWeNfdgbS10kmAMiQpaFeEQp0xXce+MZr7gMJE9g0Xmgap4fINQrN+kmfwZS0QfI3M0OVPbDOSN6vkyC+AqBNZxglCtYXu1O1iDtOIbblULQJE3vLW7aKHEPMeVxKPenpwSxZ+iiz2cO/08eif4c76Jo4JqFJrJ0xQQc2E+ShM3eAO+ztyS2uDNR995z9EudO0s2nd7UeGYZ4KQvU1IOpm9lrGgEPWlXqesKI2uoiwKBx06epXKh8EDDUlcV6IWNkOToOatU3g6M8Jh5vJhAZAQiFWi4tqCc//Np/kvXAjUj0YNi9ufbrcMn6Y+VBHlDeuQL2eFBRea7
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199021)(7416002)(8936002)(5660300002)(8676002)(34206002)(36756003)(38350700002)(86362001)(38100700002)(4744005)(2906002)(37006003)(186003)(52116002)(316002)(6486002)(6666004)(478600001)(26005)(6512007)(1076003)(6506007)(66556008)(66476007)(66946007)(2616005)(66899021)(41300700001)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?H28vzIp2nlDLzogHG8hqqfpHwoWJU9pxwk1jbzqX7Sxu5j+m6ZzNVHKjR2Dc?=
 =?us-ascii?Q?TcvnPKkbA34SwLIbcvWVPrpd4GH+nc6GSLMjbaqtKmE/fTDEshIwjZ0OVHHQ?=
 =?us-ascii?Q?b9BUvjbSnYaYkuDC68zdcvRTykEKhzghPhVRp37WYa5yBsfb0jxFI13n69Ar?=
 =?us-ascii?Q?uwZDPHpxDD8XOc+OBVViR9S5bhTfjSM8bu/R23YbpheFDV/2y+HR39bLM+LH?=
 =?us-ascii?Q?G3d8d58UFB+1KmaPsapLWLLL691MHAv5xEPJVbK89baOdGT3Fn2b4fM/E8Qr?=
 =?us-ascii?Q?3BpDHxRiDkJgo8CKnaSfjFSaBUp5sE86KCoY3uKgvSkSryRAjBjr8QbVFIlY?=
 =?us-ascii?Q?8SiQjA2l3wdOU7VCugaKqXKMK6A7bBbNyXEi/d8saIlKUOz7NdKkYfhA9rww?=
 =?us-ascii?Q?o7cy4aDw9BC2v3fpJ+09IF7Z4FXSSdUNZYhvsitDePXqIWv584+BfbrrGVsL?=
 =?us-ascii?Q?Nohdmj/DTDbAwj2/yv1GvK5I8tGI7JconX6fqg/bU5dQRquxJJrevj9qHm1x?=
 =?us-ascii?Q?JtJ/Uh4rElFoMWXFnAh9R99cLvEsQ/rxQ6krtv5CSG0F6kHt1SmhvEYuHeye?=
 =?us-ascii?Q?gcWmU4sotbOo+gf3xwyM5GP830DBdOxugSgRNcrPi/+KerdQMBqxSYJWBWCE?=
 =?us-ascii?Q?M4wQXN5ltaceHI138eVDA1v4db61VYV8BAA8A0VzmbovM3TrnQlg5nPN0zRF?=
 =?us-ascii?Q?Tw6h5Z6MhJSIm2oq/Tpm1oCaUnqjX9VPFtLCg0822GWZPEQ1tOvCWcDz+Mh+?=
 =?us-ascii?Q?EvU7gmxxsAee113J/81Hc3laAiLAxdV8dI8/9sgXW3yTJy8VgUFsGvI7d8cG?=
 =?us-ascii?Q?EuJ6Gzg6qKGxuDIYkM0QqmdtvC5pDEzkEBl2YInnSK5Kdg7VI6N5gPRfAQ9W?=
 =?us-ascii?Q?99BORwn8DPzNuk56oQ/eYRP00AAoIs40I+3Xp8sq0mx5fgMEK+oiDCcWwAuG?=
 =?us-ascii?Q?2JCOWwyuKFe3e4ivmWjr/WGDaFsi4kGar5WC0hEJ9575aUrwoSDcafKWHok8?=
 =?us-ascii?Q?V4sPbz2u4IXvIa/QpDI0QtDF0mbVhIgxNU7lmDv3+eblj3oD5DpydfKskDMw?=
 =?us-ascii?Q?KdkciPr9KbaNNpxAuWWj3L73Fm8FuIrO8jUhH7z03WXUcIl1sci6dtK+dW9Q?=
 =?us-ascii?Q?1o4TG58kMNzU/GI3xiz+kMa2MMrbLHncJRIaO7VA+yrzd2uDr2xk6PyPrpW3?=
 =?us-ascii?Q?KaUZI9iaSgU4CMjjNy7i0tMqmwOzPiHiADAu9R9jbOvL7JXYWrT5AaT3fHMh?=
 =?us-ascii?Q?AD4i6vAMr3StXWQvl+USGY1w3CQ6/FTYQUkjtdm89fTIcTfUuLlY6tZoyUZh?=
 =?us-ascii?Q?oEzg1ULTI3krR0so4fIcrUmqzyjkxln5YZzO+87nGYDnmoaRkW/2+Tk7D0+b?=
 =?us-ascii?Q?Q2TVAdChFJx5qgeG1W1pzqgKlZgj6pfYEbxTkWpJDYyQuC7gVbHnccck4cvG?=
 =?us-ascii?Q?HqqTBQwYYnZOkf1xK7hp2tOCaDcra59dlZkco71RFagJAeYIbO1mlvXZ6L3c?=
 =?us-ascii?Q?P+gk2h7BipgxFcqNVEDi7vs7JjNtIdBXzhmiLkz9hHVOAICZx8QMcMSXmszR?=
 =?us-ascii?Q?OyImj4s1LosQhR3+knn7HISh8aB4Y6YnajyzCwmO?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85370b1a-e5a4-44ba-7ffc-08db36a5df64
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 13:50:25.0859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPlX4ZSuGSsQcqJ3P0siIK7nXpkZInxgSNlQfjybFzkdkhdvtCWdJWsDozY1V+F3a0pOMKWLju7HUcMyt0Xohw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6245
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
Cc: naohiro.aota@wdc.com, rafael@kernel.org, gregkh@linuxfoundation.org, damien.lemoal@opensource.wdc.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, jth@kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

> > Meta-comment, we need to come up with a "filesystem kobject type" to get
> > rid of lots of the boilerplate filesystem kobject logic as it's
> > duplicated in every filesystem in tiny different ways and lots of times
> > (like here), it's wrong.
> 
> Can we add the following structure?
> 
> struct filesystem_kobject {
>         struct kobject kobject;
>         struct completion unregister;
> };
> 
> w/ it, we can simplify something:
> 
> 1. merge init_completion and kobject_init_and_add
>
> 2. merge kobject_put and wait_for_completion
>
> 3. we can have a common release func for kobj_type release

It seems that the above ideas are not crazy enough, maybe we should do more.
Any ideas and suggestions are very welcome.

MBR,
Yangtao
