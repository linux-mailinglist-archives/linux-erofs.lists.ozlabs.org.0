Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 278071A980C
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2020 11:11:55 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 492Gnh3ctZzDqv3
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2020 19:11:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=wdc.com
 (client-ip=68.232.141.245; helo=esa1.hgst.iphmx.com;
 envelope-from=prvs=367a5aa7f=johannes.thumshirn@wdc.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=wdc.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256
 header.s=dkim.wdc.com header.b=h2dJPpfp; 
 dkim=pass (1024-bit key;
 unprotected) header.d=sharedspace.onmicrosoft.com
 header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-sharedspace-onmicrosoft-com header.b=IB/SQjf9; 
 dkim-atps=neutral
X-Greylist: delayed 67 seconds by postgrey-1.36 at bilbo;
 Wed, 15 Apr 2020 19:11:44 AEST
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 492GnX3TYRzDq9B
 for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2020 19:11:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1586941904; x=1618477904;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=h2dJPpfpxtpiULLA6Kl6nOVPnfcoEKPLztRO9dpQaCBdMQS4L8TObjRn
 J0suhzv0lUlAMWIvrXeSzRYMfN52gTXODxB6mFuG4AgYyaYYi1ANHAOZ6
 C+CBdA91rTcbbkRQ9NytLLxXH+5srqV0wfsJL48mgKt5L2oyqQBm6JKF8
 HQNn3I/VB7RgGMFbjWFBQiQ31l0rM+Cqs8l1oH9wM0kb+OfwxfSp+ZJGQ
 N3SpRHNxLyQWobIURIFvEmG9GkWWxhn6xYw97XnZlTV3HFfQ7UVr2bdy2
 rchFDrheMBNAAzidXigSY9Ck2qT4ckKHIz2xj0RTiZZAZQBlfngrYoHZ0 A==;
IronPort-SDR: 95i4dpGue9eNjoYk2K/9cbOToVeWBBtkiWiQhEHO7EFSD1h2NzcPaGUo/1aPiT4V91hLq1wdEu
 JkZ8xqP4mXpXp5SOX/Xmby+I5FPE0PQGo64RvyPtXSLe1rR1eWQCBh/n5ZqGNkWddjcHlITDQ7
 Em2CIJuLg2GWAh9K46RexHbC4bfKgJSCUp2DBrlqFOy3cuWpfNvQik3ltm4DEvJSBQVOAs3W28
 tUMBtevXNEyg/7USRKfOrqenmsbSwLJ1Q0bmbVgbu7Aa3j23lF8D+9rCxEwKNKlpZ8g2eVSPTQ
 c0A=
X-IronPort-AV: E=Sophos;i="5.72,386,1580745600"; d="scan'208";a="244033360"
Received: from mail-co1nam04lp2053.outbound.protection.outlook.com (HELO
 NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.53])
 by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2020 17:10:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2Xs028JgTBHrlnEvgJ/p8UilVh5M2YVmknCeMUfx9kjOmVae40x9oNfqJVGD3+OJbuHLD3osu3GbQv5GvVEWg7Vj3i12IKHT3oHuILszhJ/V3PR4QjzAV1FPdU6UlImyL4GgSZKStp6C+pvdpbz9AJn9vW7U/47vWLgpfGExKhVbKJAmxKL2rfdAcCmLdDOqlp3h7SsPJvmi43IcG9aUXOkNXMBm45ntMBQg2r9kRXA5ikuFPZJj5S7g8sX4wZL6JgPKIfKlRb/3+DrPn7/JiAO0iikOUiNRIwTnNiPabyf9bNf01b151PTwLi5e/LI71mnB7Nxjp36ipEiTefvnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=i4yOOBoRmCsR/I7VlSR8v7lxEPPqjbgrQ8/cDyGRfMsnOKWxhrGtNBYhAXUytn56jl0PeYD8v1PkAFnyMb4R5rekL2rorkgKqG9L3kiJVV7d+h/gW51sXpSZ+KLPRvRC77wFPPpDO4uGs7e+Irro4zli3w+lxkeWrW6NjsRqAfsvs7ntp9SGYNsDpOkgnPpg+slNmTCtjW8QVtRIGYqTIYni1C/pdUyGSQOf2NCjn6viPb931MUWg2h9YKcx9ik0zKl31ZzDN1ffWc4YiRgHl80JRui8uSMmDH3Xyc+HGH0X5YXoGVn+9SujlNAiyVDZE8ytovBs6k8zCvIIPfjGhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=IB/SQjf9mKvmSURSWenwo2Y3VQ/sD/la2pZc4arPiO0zUuodi/0B2/hzs3r8SJ4FxLAJ+BWlug97gAuhSAN5808A54ZOkWmOLDo4798UwGho/fQBReZ9ouPIcovvEBddtkqaD5FXuN7I/5oV2FFffju3BfoSlkqZPrqGpgdNiTI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3599.namprd04.prod.outlook.com
 (2603:10b6:803:4e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Wed, 15 Apr
 2020 09:10:31 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 09:10:31 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Matthew Wilcox <willy@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v11 01/25] mm: Move readahead prototypes from mm.h
Thread-Topic: [PATCH v11 01/25] mm: Move readahead prototypes from mm.h
Thread-Index: AQHWEm/+X7EfNJ2OKkyFI+rGvCts3g==
Date: Wed, 15 Apr 2020 09:10:31 +0000
Message-ID: <SN4PR0401MB3598C4E727F07B81F75EA6719BDB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200414150233.24495-1-willy@infradead.org>
 <20200414150233.24495-2-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65f197ce-a436-4803-b0c4-08d7e11cd958
x-ms-traffictypediagnostic: SN4PR0401MB3599:
x-microsoft-antispam-prvs: <SN4PR0401MB35994BDEBB4BCA4B125C10749BDB0@SN4PR0401MB3599.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0401MB3598.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(54906003)(52536014)(91956017)(4326008)(4270600006)(19618925003)(5660300002)(33656002)(110136005)(316002)(186003)(6506007)(71200400001)(76116006)(2906002)(86362001)(7416002)(7696005)(558084003)(9686003)(8936002)(66476007)(26005)(8676002)(66556008)(64756008)(55016002)(66446008)(81156014)(66946007)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eUZe0V7dpVRe38Qbak+OXZnXMUyn2jT1GpYBt1XC9V2HJ5Xyago/PL79j8PJ7619d2CH50W5/iS8pHaam7mIgNQNZRbvaicuoSDerHprEzxgP9eZJqtrq9NCCJfQs9YMXgGl6qtzBp4d7ksbQayumPPqBS6CDrh6YZs1sL8hb29So5FmZ3+SogifY4lT5oc4Lnpiluy0Kc4JsJSjE11g2BR6gOGvCVYGdoS0ma1fhbU0L9Gqp8MJxV4b9QkZINmG1LAisy4WG3FHHVRYneSdJLQmbKvqj2qWLu2IiPYOCWSZ7VOOw6UsRiltYIMccHb81ZRxHgAeqp91etm8J71vbObfkjaVsk7VG0W1VgwAasdDG4wu0CyiIFMukSnep8TMPWZ2CEg6zwLe/HFT06TK5J3vkUI0yfY6iCBO1bdyFsmebbUmDkmrO2pLCi/Q4mzl
x-ms-exchange-antispam-messagedata: qMgzjpfOIFZuBsMKi59iqhZM4tReTMgOPKnS76raZ+3KcRbEKzSza4SbkVVNRsq7pQNw92YUmPtibdfvwNsFL6xcmfv8FsxlbXu+l+1sqzi8JXYMmslLPvDBbFkpr37lGmGMCfDrJoh7IfJfypgRvg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f197ce-a436-4803-b0c4-08d7e11cd958
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 09:10:31.7107 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZbWFK7kHx7rw59FVwqO+RfmhITfV5Zu3Iza6p3zBcbXwLKKUzSNQZljS1V+A4nBx7sdlgjD7Vb6RJQ1i/Ys64htwy3/Mpy5928efB5Ofej0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3599
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
Cc: "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 William Kucharski <william.kucharski@oracle.com>,
 John Hubbard <jhubbard@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
 Christoph Hellwig <hch@lst.de>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
