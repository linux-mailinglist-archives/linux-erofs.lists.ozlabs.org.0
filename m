Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAA8158B32
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2020 09:20:39 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Gwh40l5DzDqMn
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2020 19:20:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=wdc.com
 (client-ip=216.71.153.144; helo=esa5.hgst.iphmx.com;
 envelope-from=prvs=3037ffdec=johannes.thumshirn@wdc.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=wdc.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256
 header.s=dkim.wdc.com header.b=gK8WbN7i; 
 dkim=pass (1024-bit key;
 unprotected) header.d=sharedspace.onmicrosoft.com
 header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-sharedspace-onmicrosoft-com header.b=IE59z5+q; 
 dkim-atps=neutral
X-Greylist: delayed 66 seconds by postgrey-1.36 at bilbo;
 Tue, 11 Feb 2020 19:20:26 AEDT
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Gwgt57jxzDqLn
 for <linux-erofs@lists.ozlabs.org>; Tue, 11 Feb 2020 19:20:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1581409227; x=1612945227;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=FDQF7YmUbf7aiT8pwm9gfOrtDMSYksmXliNItnHvbJM=;
 b=gK8WbN7iIxTwkJJ10Nh/ZLKGOVknqpWlP2RRRxmngrFflRdvrIDGQE0e
 2XRObHGnTmdxQIyZVkBPKKsu5sag0frlxl1G/gGh06GqvjcNcISZ1UxaY
 NT/z2YYQZhO//GC69zJ85Pusy/kMDfrz7mrP8mh9n8R6kMk7PhvMuAlTU
 q86HTpOTlikgX4NEuYF1nOC8wgahK0Stv23oa6U2AhgvuikFu3dkpEIg2
 lm12gwCg/16ud+FSHJFxE7aiZjU6CPS8wbdQZg74Loh6aQP06RshVKrO7
 gL+1bONOeJ/PREOVpt4iYpndiv+GHcHJhkBU8qCXNrmIPpMZFwshS801e w==;
IronPort-SDR: TTpGiZ+CrPrMqQD08kY+UMnaQ1VC8AGR3aneqoIUUY8TfLa6+gcKWb/1LnnK2sf5VVJpNfwodD
 eprhvkWp2D1y/As6LgwFt3RkNXQxROHtkx4jMzzq2dBDB1cytEO8cGS3akB+WaKNt8yrJkbpj1
 zT0ezXDptkOTRqEcQHdOzE/cfAUd5swPx02ua+4uNLHkxGkhvTzn5PlkNbyziR0tAnVQudOrXx
 PQTfZviWsfowVKubfDgGAxm3k1l4SLnUaZ45XNsnA1nGNnC+rLBrqC2Xyf9me48/6WhV6Eh+5+
 wJY=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; d="scan'208";a="130107721"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
 by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2020 16:19:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DbOZ8PGX+pHGj8jZlYa7H686mXG5I5hjC92WnaqgN4AaL1gNhTtl9g7728BhIL67Pa0SEs1xZAyZAGhEQTofn5LAFhTdska0A0PzVs6pGyB1XgR/LCfyB6uGVWIuSGnL5qUFNBrtePvKSatxT9R3CdxPvlAvj40OFIEQYeF2Oo7BTj9ik96CBmVvuYLJiPOTyO7zaQhEHWp+ChZN9m6YA2j1WApo9+wqzAPG5cLPt7R4oSOCxigfzlOyrKE2dPYb4Syn/UBTKOOE7pTe2ZtcFP+rV5U8LLsnlfd7uswgujETcxbAq1xcN6PJboAI7yit67u/PIGryqHT4d6nivZY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDQF7YmUbf7aiT8pwm9gfOrtDMSYksmXliNItnHvbJM=;
 b=alcXa2EsGIL1Z1u/bimwyTA7Z1Gty5+WjaSIQpFBB4K9SRRxxKCP2vYM00yM+hHWb+rQEhkqX9Mm69yJdDGCIDH8Qq15nK31VXN73KaKL9u9gqbR7kEkBOmM852kPwJ/9T28xpwxHsiHXZahx5Ur+S5/SOIlrCtM2cmkVGYHl1ADIsMVFJahFmAJo51uFIAHT0QfeMSuaYrgJXFEgGc30FC9URtbi7lk6yddTRk2o/a3VGsopKE/9U/BC/O2/zjJL2VbgJp4JOo8wNq3qM0VBAAiLyziETvtJ6T54/vgOTszX0Qw9P5trPAli3mSLfXHlw7Y+6Iuo309lC5cCyFJ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDQF7YmUbf7aiT8pwm9gfOrtDMSYksmXliNItnHvbJM=;
 b=IE59z5+qfoiES6btuEYw/qK3SrBZJVRQBphYhK1Uw3zNftDlj6VNzH1BRJ/yIyu/BKfKxpJWUYdnjofN5YZFl0xUfRoZXWvJQ/sZzWWAakENjX/lLozVrqWiPsn83F7FeohsxPsQw6bb89DWHJS5tPdZl9XZr98kEnwJbxW5UG0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3600.namprd04.prod.outlook.com (10.167.133.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Tue, 11 Feb 2020 08:19:14 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 08:19:14 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Matthew Wilcox <willy@infradead.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 01/13] mm: Fix the return type of
 __do_page_cache_readahead
Thread-Topic: [PATCH v5 01/13] mm: Fix the return type of
 __do_page_cache_readahead
Thread-Index: AQHV4HdLtCSr29ig40CbWBOKZ39/Iw==
Date: Tue, 11 Feb 2020 08:19:14 +0000
Message-ID: <SN4PR0401MB3598602411B75B46F5267B829B180@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200211010348.6872-1-willy@infradead.org>
 <20200211010348.6872-2-willy@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 783a7c5e-dfd1-4f05-3ff8-08d7aecb14cd
x-ms-traffictypediagnostic: SN4PR0401MB3600:
x-microsoft-antispam-prvs: <SN4PR0401MB3600BE4DF5FBBC2A07AC38609B180@SN4PR0401MB3600.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(199004)(189003)(8936002)(9686003)(86362001)(110136005)(55016002)(52536014)(5660300002)(7416002)(66446008)(54906003)(8676002)(64756008)(66556008)(558084003)(81156014)(81166006)(316002)(76116006)(91956017)(66946007)(66476007)(26005)(33656002)(53546011)(6506007)(7696005)(71200400001)(478600001)(186003)(2906002)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:SN4PR0401MB3600;
 H:SN4PR0401MB3598.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J13A6ReA9TSTt1c6bdBpTxtzneb1Ofpyc3HHteWqvtuXD5BIp25wWX5Jj9rty+z8IuBPjt/gIuHTYUfEoYTkHZrnnDILfKSy45g6ryMvZTy61yO2Q+D6ULUDMigsCCjurNntAWZl0Xm/OPaC21h9Uhg9UsfGDU8yRR7pJp/4RtZPLu8Aa+pkHWfnddkRl+me9f0vLAAtyn91TZCvcIqa+pIWQqEAD41sQwhxTwrZ9YYK66o/AOKckkO5BFfhPOEMko2jHkIElHDKQ2xLih2gDaEWxDyXVbnwiNcDQ14fDOc61glpj0fPDXD9wLRF+uURWIoMWc/4/v/xEcylXlRAUCkkC3JGDfLGO5P1vDoTTsL8HhGcdLdCMRrLdg1L3yxaPXNcB6PpBTBIbmB1SpRGyXF5mmIccM3isWoZ/4rvj3nw9fQi+IKdlplFkQzhShVs
x-ms-exchange-antispam-messagedata: gfEyOKrwkPk8qghET5Arq6HHfBJaC0LBjYfYag1yvJsZYT4ZAH1sGnViMxzNGt5I12U+7zjXvc7zduxy+tXWxZcvuxjY2ApX92T48YFRi0PQXQLlLzOjG4KsqnzrprU7tnMP+4Gc0+BVeUyg7Qnipg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783a7c5e-dfd1-4f05-3ff8-08d7aecb14cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 08:19:14.6094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +UkunN43yImZCGMmfIBExV/09gy+m2seRDcVr8m/zRykHkafS94C2sa/Bp5+xgnFqs3xnQdRlYKfhKG8VEjtTHo39tQdr+ZsU+hlmizKQRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3600
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>,
 "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
 "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 11/02/2020 02:05, Matthew Wilcox wrote:=0A=
> even though I'm pretty sure we're not going to readahead more than 2^32=
=0A=
> pages ever.=0A=
=0A=
And 640K is more memory than anyone will ever need on a computer *scnr*=0A=
=0A=
