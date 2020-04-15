Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C22E11A98FB
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2020 11:32:43 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 492HFj0dpQzDqcX
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2020 19:32:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=wdc.com
 (client-ip=68.232.143.124; helo=esa2.hgst.iphmx.com;
 envelope-from=prvs=367a5aa7f=johannes.thumshirn@wdc.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=wdc.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256
 header.s=dkim.wdc.com header.b=flnntCYe; 
 dkim=pass (1024-bit key;
 unprotected) header.d=sharedspace.onmicrosoft.com
 header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-sharedspace-onmicrosoft-com header.b=GDUPzBkG; 
 dkim-atps=neutral
X-Greylist: delayed 125 seconds by postgrey-1.36 at bilbo;
 Wed, 15 Apr 2020 19:32:33 AEST
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 492HFY4CmCzDq9p
 for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2020 19:32:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1586943165; x=1618479165;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=flnntCYe/yJkQdsW5lwfoJ+r3aekSNkSpHpi6cSNN8tkN82uCrgUs+pr
 OKnMxQPoOeaRKreLdwIRwfHnNCFNPKM+ZvkzdmrMiy5TwsYgXduB1d9a/
 1LMc2FJ94SFlQenbCVhjpaftA+Hy0k8LYy24PzIWgwrpYRPrjD3jL3cTC
 PUhdhWqmk8mosCUVPn0riaYgUYN+FvREhi3t44qdmvYrUZ7JqkK+BW9hi
 dykkKS6Dr40fjypnR36cJkHEW9a5yftjVHvDf+yGH+YE/qqToaqkouVlv
 Tk3TcgNkB/9PUqh4AebkYsWBGAiwMMZxn+8PD4RyJb2+g7A3i0IGlK0uP Q==;
IronPort-SDR: eeRVIlNT7jgc5Ig8ZYnISAlMPD4ZQ9FY6eT5A/Kzo4C9xFYVNPO8mZYw1nU47bM/qi+jwjMgqs
 Jkm1w5xc0QIFmrCNltcXPYA1jgBzuZYSlkKBRReE8ZdNZ0iV7Wk8chgJsOyb+xsT27de56gsa+
 IxTUXDmASKQqo2yApvWnC9SUrNct71/VF3SHLxocRdXHNX3Hklq9nbrE//cCq9i6yRm43xOAQG
 +46gYBKDjsjJbq3IBnWH4hKnqld35SXuN+1u3lOGCEjDN44tbz4VHCpqYlpXgSXmvDpjq+vlCG
 5j4=
X-IronPort-AV: E=Sophos;i="5.72,386,1580745600"; d="scan'208";a="237794025"
Received: from mail-sn1nam02lp2050.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.50])
 by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2020 17:30:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYzXWSdNM8Lt6zEhh6x8il7DwIbzfOs/ApjPtGwx+tSr7wGKYtlBPoXHdzXMG7d0/aFqPb2Uz20U1P2ixPrnwbSbVgZxB3HpOt81gNvmOIJEqBfpElLvLVoHx7HREHuxEtQ31Ms14+X3mVRcaA1UZ/iIz/jclfo8s2DzByGruMfix42ey7skmC4m51oYbLU+vGV1KRxLjpfr9C9daOwgj5KQTAHhLU16rNc6AhXMQlgMAAunPsYM4mbN3oXQ0PG6pWcN2r+Vzp9G4YJ9BEcwQH70wwRvgWj/xx2KQCUFiv5jMNUqC32Q+VJzuSjPxH3f+BIXpO138bBaxFRsC/hUbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=G7naXZ3zL10OBDewhQWaBOKRtj8ZeZyC2iD2W64nrHRPQQO5xYGeH6q2W1ABaZVrjWt+wUD6a9teFXc6UKFqcWvyNHAJIf4gcuYen9yDten24ZMB1SCKZwlDNwGO/JJjt9r1d5Ff8HFk/KfP86iZrld06ki4pFB+adrlG/G1WoEQfeV+t6A2+Hz2Gg5TVQUEg0+CS31cpCV/Qdi1pUONiDto5Y39N7aC269R6NyrMXQq+X2awd5YWqHZN5doLMI2b3qOztYqskjdKImZPp7tyNjRCQ2+wkO/GFwIGDBlOmJYre55qLHC529WehfK2N3OtZvditWvv1g1AMCAAp8b1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=GDUPzBkG6XEq3T7jskycK6rXY/CFtZb4ekXvp9QhqVyenQRG0uSPnw9vT7w//uDi3pha9a2ll32mHD8S6+Fgnsl9JLBu+UDtsczdvujff0fLIng1vmCzTUkbHuBjB9JNFGTV/xVS7RLcSdQG1KcvyJ8SPc+xQ0FXHtpECRVXJpg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3632.namprd04.prod.outlook.com
 (2603:10b6:803:46::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Wed, 15 Apr
 2020 09:30:21 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 09:30:21 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Matthew Wilcox <willy@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v11 06/25] mm: Use readahead_control to pass arguments
Thread-Topic: [PATCH v11 06/25] mm: Use readahead_control to pass arguments
Thread-Index: AQHWEm3c6YkRzif5rUSh6nBZ9gJdcA==
Date: Wed, 15 Apr 2020 09:30:21 +0000
Message-ID: <SN4PR0401MB359806A3638DBDD9A20DDFA49BDB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200414150233.24495-1-willy@infradead.org>
 <20200414150233.24495-7-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42318151-4e49-45ff-ce57-08d7e11f9e5d
x-ms-traffictypediagnostic: SN4PR0401MB3632:
x-microsoft-antispam-prvs: <SN4PR0401MB363240B9E9E1F4E5A00E26469BDB0@SN4PR0401MB3632.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0374433C81
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0401MB3598.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(33656002)(19618925003)(9686003)(81156014)(55016002)(8676002)(8936002)(478600001)(4270600006)(71200400001)(52536014)(2906002)(558084003)(86362001)(4326008)(66476007)(7696005)(66446008)(26005)(64756008)(76116006)(316002)(66556008)(54906003)(7416002)(66946007)(5660300002)(110136005)(6506007)(91956017)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3E10msHK2KLvXhznHQ9YJSWeEyPFo8ruTznCKt9trFhmCR2ubEYYVZQ5b/qZ60py5RQMtoBOOTichvWC82eTA779GWZfMYR+n0jwC9j2a1xIBnbe09XNSwRwrMwDvIevghhMnptKQqtFqaSmu/jq0r3dODtE8PoxNftmxV+jYAdqDRMjjjwZD4jPnKAcUZW78ropg/d0uN3EWCOImEWOI9nDXWGT+cMBQGduft9DTkhoIsFGr3OSrQbdP2Sox4bWEi6wL770iXty0EB4N1Cl9XWJvJ4wffLmvT4l0Sdec7k1g3JcoF18QD7hlAR6OZOxQfuIC0aY2D1/5DFciZV3gWw9lfzVsMXD1TlNLfkcoOY6D7X/ZCzJsjwfXXhxtPqMN6+gV2hUmY1c57tvqS1cdVq0hDa6pgqY1eIXnoLUz+KcDUJQfezMtja38Q4FVPCE
x-ms-exchange-antispam-messagedata: mZpW+p+O8zplPaT/JT9mfTC0+kdX2Wm8ycHn3eyabru/ZJeiJGpXDT3S4AcOKIMjTHIna/2LeOItwYoZX63oqxV5WyxCc6oguXWZpQ4vFer6Rl9IkMhWp3vcp/+/RWaZOM9Ce+pvoAKqUGq6yA2o3g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42318151-4e49-45ff-ce57-08d7e11f9e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2020 09:30:21.2508 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0pP1zzxdZl0sYzuj3YYPXddr7XLPy9tBvfWuDosAZ5ZaDo5bilbGlM3XKFZhSyUvGW08IS3GnI9W4G7ina2KBTvZbjegH1JZwCwK60YvWoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3632
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

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
