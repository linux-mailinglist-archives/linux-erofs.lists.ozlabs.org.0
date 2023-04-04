Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6211D6D62D3
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 15:31:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrTDr1xxpz3ccr
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 23:31:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=i+boe1mr;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vivo.com (client-ip=2a01:111:f400:feab::72d; helo=apc01-sg2-obe.outbound.protection.outlook.com; envelope-from=frank.li@vivo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.a=rsa-sha256 header.s=selector2 header.b=i+boe1mr;
	dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2072d.outbound.protection.outlook.com [IPv6:2a01:111:f400:feab::72d])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrTDk3s5kz3bWw
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Apr 2023 23:31:15 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XLW+FfGLbFNH0K6bSuFthBS/jJNQQewTzP4m7ZPpvd7Am8U67RuL3QrSk6Hia5NvxLiGAaVDyhlyFTgfJ3BS1Y+FBC+aw/hBjcY2+UadrjsMqqwUKwc6hPYSnfzS3iwggtaZuPWwLye2w2RFo/bKPd5SwAShKVrGvkPBI4yuqTIPbXBhGB95B5yx5Vsj+3Qfp91Z/brffrqXBqO/NEDhkNDuzJ5/9iZOTp/v60S89h/gl90AJZ5Mgrnu5VTS9GrK0VVP0TO1lir8xdmpEj8r+M1eddFLE4BQnf8pmIPWVppJYCGMRacwFFVjfbijgn8uzPiJXx7m8oQxKkhvdrEJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9gRzrJioyaXd7x2Nt5LwWdJliejgTOkFIZ6yPNQB8M=;
 b=h7j3T9cXJBld+9xJQSOTknxSCAoe+0vwTVs+7rA9wv0QuatbUGEnEMTH9I4YTvaNiXZo2TVU/7/mWBtedexXmpfpHi8eTJSk7ixfSk5VaTJDwJCYsl2Q+o4uuA7Q+olwZFRrLOoNVcN3VnfYl5uDVf7P6rvZocQlP4zPnZTgVe8RUMuI3d5P+veoXYt/V5a+YGdywNMvrbdMxF+UyBScnAzFrhDk27Vkjv2mEG1QQx+gu/1pCuGgzE/7Rl52Eel5/bmjtIULo4AZmCMVLw6lfF1nTCEeOjGVKSWeos7YVepyvNzMrAqjytLjnROHDxvOpg9I0u8vQRRRAvR++XUlYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9gRzrJioyaXd7x2Nt5LwWdJliejgTOkFIZ6yPNQB8M=;
 b=i+boe1mrB9bH8RQ0WUqR4nlBCrj/YrH90RKuJZq77MVzmLBSKbWu08HJbppLWYB6gKXGPViFAJx5O4VU2dtpo9m5vwIURruNRIehpcgtlA5Iuz6O2R6fIqxkQa3iNaUZNXQ5bzvVPKIVvjR3wd2bA+32D79iBlYrjHYSKxWCni3Vc8gEoPZqw3M6LtPtXd2oM1ir0Me7v8KWk9xenS+7Qxlbeg+RaduepbeuB9apDuNv2tkwNIYDXDi+54OxQgxi0kcfU5Buzb1n/dqsc+94K4KSVzlILDL7iz+PhG6lFxoEV84WYiX5/TmAr5DC126aBad+T/S6Rf221yr0+G7vIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5493.apcprd06.prod.outlook.com (2603:1096:400:264::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.28; Tue, 4 Apr
 2023 13:30:50 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::a3a1:af8e:be1e:437c%6]) with mapi id 15.20.6254.028; Tue, 4 Apr 2023
 13:30:50 +0000
From: Yangtao Li <frank.li@vivo.com>
To: ming.lei@redhat.com
Subject: Re: [PATCH v3 01/10] kobject: introduce kobject_del_and_put()
Date: Tue,  4 Apr 2023 21:30:37 +0800
Message-Id: <20230404133037.66927-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <ZBvgpBzEuFuyOD/c@ovpn-8-16.pek2.redhat.com>
References: <ZBvgpBzEuFuyOD/c@ovpn-8-16.pek2.redhat.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::15) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5493:EE_
X-MS-Office365-Filtering-Correlation-Id: 5498de48-66d1-4654-42e7-08db3510ce6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	uPbuGoDXSeq2G8qkidRuQc+pmreSvZwgk/1fJdOkk0W38cqYc+nwLeHEaJz+HGEtwSXfngK9mpg0jT9VyhweX+cNrUVV15Au7aEQYGqQ80t4zzz5AHAuKZ5c7qM/sRPikYHcrKVXs7RSUtFEEX3kuNWBlvjtvFreJf6XlTID+luPcQf0kThxZ/0mJ523uTsOOLZIBhAZiypsGTt9+WK7ydJJ48hoCXJIQu7p+/52pwBnm54Z8WfVUTsvROIcOK64OLReVHatnVBY/q/M1I0O2x0AqBtquZXrysEXv+l2PKmH+JyVmV6W+kEm035IJPdupdzhmNX01y2Mtp8YgmHBrQNyRU32kx+KdK5HWtY9Zp59IGNF9XfyQ5W05ccWU/FOUIkklurkVn1qb0MsjGsEL42sTNt0imLWPPvwJfv/i8SSAHhq4VjOAZAgnoNG9l33ZXhCaReORrLING3UJXmRaeNvxOaIMqp3DOCfVQOI6ZrSF04CC2Onj1dR9PN3efROEPYBRp47zCaOC4uiAL413FIZKeYVv/O2g8P2ob7J2dFcNOtewb0BGxTn8agJByiF8hst1rR7L50PNJtKVKZjJ64fs+6t2497MauOuL0lYDzErupRuJBHpiR9zEC485Qe
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199021)(36756003)(4326008)(478600001)(41300700001)(316002)(66476007)(66556008)(6916009)(186003)(66946007)(8676002)(6506007)(6666004)(2616005)(52116002)(6512007)(6486002)(1076003)(26005)(86362001)(7416002)(558084003)(5660300002)(38350700002)(2906002)(7406005)(38100700002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?EWVPo+rePAbl9b4fCmMtkqjYyYgnmwI5L2Y14rUKFwmZ3yatRdZbP+ClBWlE?=
 =?us-ascii?Q?CfsWhGbCmnDIreNr6bd9xgqlzhRQ21tg9mJlOSi8mt2bTfH/1QYXhgnekwFN?=
 =?us-ascii?Q?K97EJEJJXjky440IsufLAaWT8NyYExlqT/fFolEfO5fk5mrwcyNPRn35uhNz?=
 =?us-ascii?Q?cU2rUalDdO4BeD58o8UOXRMx0PTKlP98CaYgsi+K03aRznL9WWbm9F4RSl/q?=
 =?us-ascii?Q?OdUatbj3ge+/+/x1GwtHdNtLx3sy0CPDj1sG+hWAngpYuhucDgbF64Z8uJU5?=
 =?us-ascii?Q?hjGGsb5Augroy7h6Jp+IPwn4u8MyFkv5/eLfVR100maTq2hzhJEJHukivZ+c?=
 =?us-ascii?Q?xi75G6PBsjocgUinQ4uj5MrkovI42py3ID3HzTQRxwx8N1pYJP+FE7QS/D+M?=
 =?us-ascii?Q?5VreflTyaDG4AN/bDlXZIlgdN9+6o+XkWz/EQbWaco7SWjUoHy6X3lrvvkby?=
 =?us-ascii?Q?Bu1cykM5++pCDIg5kgVYUaWYxueV2q6u07Gy7A3aFcU62i59PrI1FM2qYF4J?=
 =?us-ascii?Q?x3kkrW3KbIn77mknRdmztbt0cC+9Ze8NrxVrOJguMjDLHV3wNMHC7aOC1Aq0?=
 =?us-ascii?Q?CQfvvDz3yiCs2SX1H0hO3WLeiNILsPQX2Qd/syr5oKqmPjWHpid8pxEFJ6Cj?=
 =?us-ascii?Q?nFhjE/k2m21ykLEcV5ZITMBA88mmWTNY9xUsiL5S6jB/9IwZx4U8wNLSfIsW?=
 =?us-ascii?Q?F/QryYGn/lBT26hw24BXlYkF0eHPVEo/JaJvUMqZR3h1FSU7jW1I/FrMOgNA?=
 =?us-ascii?Q?HIzt3bEZw5OfSK2mtwrGX9SBCbOP/uuUPe28iwUY/cQ/5uyaa8Vkw6rz359r?=
 =?us-ascii?Q?D8lxpV6Nym34mS0AgVTtEACZx5Xu9eqQoB9+zV22q786IIZCpVZ/u1v3SB5t?=
 =?us-ascii?Q?5HxQT3MZp9CpB3EaEbBG9wKykcIVCUvCYxkUBOLroghn8FFlu/wXxUqqCl1H?=
 =?us-ascii?Q?8xT9rZPxFQs0t0W/Tdl53KfI60aYRL1o6VGM5+8vsz8qY8CHjOZnPx8o/q4D?=
 =?us-ascii?Q?y8cxzvt1PHpboeYgAz82hFW2znF/CRq43d/epb+eM45fZeJXNHR2Fsf3W7/9?=
 =?us-ascii?Q?1Df1SHGNdlW3jN5DibB/sNB7sXQUXC9g6m3xMoRB+YiGn+t4VEP3M65OC6eR?=
 =?us-ascii?Q?9THbCHAPnLDxTYovcR/2CO0nB5ieuXOmrJwayfRvk07GSDNAZUhLyBHDzU1v?=
 =?us-ascii?Q?LmvniDkvzwSXypGzxbEetX1KlQwlBn2GCqcN7/TK1Su/tZeyJspIflh+eipD?=
 =?us-ascii?Q?UKR10qP1c6Dz5Dn0iE+7BXqWKD06oUUVeDufyoQwenL4FRZm1x8xapsktt57?=
 =?us-ascii?Q?4A2LVdmxgVCnZMYgug3ecGwVnEMO8IiW4uGBkD8+RLjoQ7YoHBzh8j2OjxcW?=
 =?us-ascii?Q?HXLxRYyRIZlX/GUyL+FQmkVaBvtgIkQ3E1FJ6U6ZWefzL8YjIy1DcVMlCR1b?=
 =?us-ascii?Q?P/IaWbwe7Z0bG5LGvSRIUTXW2V0BvBLrPGyI3A6oCzGLnmquM+S31uvH6jd3?=
 =?us-ascii?Q?INDAXZzBYgFpi4HuwGufWhc8bNJeNGj+YdUft+mXgYd/TmtvpwE5sDEVQ6uH?=
 =?us-ascii?Q?xSw9jn2IWVr/jMKiMw7+RHZgYl44rcztuNBjxTwb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5498de48-66d1-4654-42e7-08db3510ce6a
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 13:30:50.5709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QahJKytFjz88voSWSaNP4RkI85OPOy1WR1g//Xa0iYLVZ2jUi+okTVlTOIjOUpr21yX90z6tp1puh6RxqtwMDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5493
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
Cc: rafael@kernel.org, djwong@kernel.org, joseph.qi@linux.alibaba.com, linux-mtd@lists.infradead.org, naohiro.aota@wdc.com, linux-nilfs@vger.kernel.org, richard@nod.at, damien.lemoal@opensource.wdc.com, trond.myklebust@hammerspace.com, frank.li@vivo.com, josef@toxicpanda.com, huyue2@coolpad.com, dsterba@suse.com, jlbec@evilplan.org, jaegeuk@kernel.org, konishi.ryusuke@gmail.com, linux-nfs@vger.kernel.org, clm@fb.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, ocfs2-devel@oss.oracle.com, anna@kernel.org, linux-fsdevel@vger.kernel.org, jth@kernel.org, linux-erofs@lists.ozlabs.org, mark@fasheh.com, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

> kobject_put() actually covers kobject removal automatically, which is
> single stage removal. So if you see the two called together, it is
> safe to kill kobject_del() directly.

If the reference count is not abnormal, kobject_put() does contain
what kobject_del() does.

Thx,
Yangtao
