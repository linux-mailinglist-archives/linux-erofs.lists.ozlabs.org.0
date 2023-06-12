Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CE58D72CEB8
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Jun 2023 20:51:52 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=utah.edu header.i=@utah.edu header.a=rsa-sha256 header.s=UniversityOfUtah header.b=DU1sLCTN;
	dkim=pass (1024-bit key; unprotected) header.d=UofUtah.onmicrosoft.com header.i=@UofUtah.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-UofUtah-onmicrosoft-com header.b=KK/p9UNO;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qg14h0Vftz30NP
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Jun 2023 04:51:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=utah.edu header.i=@utah.edu header.a=rsa-sha256 header.s=UniversityOfUtah header.b=DU1sLCTN;
	dkim=pass (1024-bit key; unprotected) header.d=UofUtah.onmicrosoft.com header.i=@UofUtah.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-UofUtah-onmicrosoft-com header.b=KK/p9UNO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=utah.edu (client-ip=155.97.144.6; helo=ipo1.cc.utah.edu; envelope-from=khagan.karimov@utah.edu; receiver=lists.ozlabs.org)
X-Greylist: delayed 124 seconds by postgrey-1.37 at boromir; Tue, 13 Jun 2023 04:51:40 AEST
Received: from ipo1.cc.utah.edu (ipo1.cc.utah.edu [155.97.144.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qg14X0N9Wz30Kd
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Jun 2023 04:51:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=utah.edu; i=@utah.edu; q=dns/txt; s=UniversityOfUtah;
  t=1686595900; x=1718131900;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=7/PdkI/bWBvMhBpLBvBDXzM597AOX5v+BPbvN9Llrjw=;
  b=DU1sLCTNBMWJSCOhqHaBlkYhKQDsbpQWQPaIBw2TAIpiS5nY9Ienaz4q
   3yacRDS2w2mUmanK1bSkbsDchFeGkctalQHWoiXZm7y5eBtsZ936HxcQZ
   tV2B6SjlnC0TeWL/1dDLN7K0zSvk4QG9uwBtK6K2ISLIITEeEJQ50keiE
   Ldj4I85QqPgCsDCMfSo5W9sYk1U3eWe0MUTSfejEUbO/I2TIjHf/YYY4C
   cuTr9T7U64ipJ2j2NndZ8fNDtTAkrtHfSq83vZJFjlPcg0pef1I5cOTAy
   lFOI1pfFQhG1Zl8mpGPJ2M4FNo5PE4M9ne29JOQcR3lxFgWrbr44iFUvy
   w==;
X-IronPort-AV: E=Sophos;i="6.00,236,1681192800"; 
   d="scan'208,217";a="236799438"
Received: from iso-dlpep-p02.iso.utah.edu ([10.71.25.162])
  by ipo1smtp.cc.utah.edu with ESMTP; 12 Jun 2023 12:48:18 -0600
Received: from iso-dlpep-p02.iso.utah.edu (iso-dlpep-p02.iso.utah.edu [127.0.0.1])
	by iso-dlpep-p02.iso.utah.edu (Service) with ESMTP id D13F5400F77F;
	Mon, 12 Jun 2023 12:48:16 -0600 (MDT)
Received: from UMAILX-M205.xds.umail.utah.edu (unknown [172.31.233.10])
	by iso-dlpep-p02.iso.utah.edu (Service) with ESMTP id AE9B6400F742;
	Mon, 12 Jun 2023 12:48:16 -0600 (MDT)
Received: from UMAILX-M205.xds.umail.utah.edu (155.97.144.205) by
 UMAILX-M205.xds.umail.utah.edu (155.97.144.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 12 Jun 2023 12:48:17 -0600
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 UMAILX-M205.xds.umail.utah.edu (155.97.144.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34 via Frontend Transport; Mon, 12 Jun 2023 12:48:17 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtGCIhKr6JC1LpHxb/DZRQS4eNFyaeybN3lFo3LlYJM3YPujK1ZPs+JgivZI73Wmd9erm0jecPWy5pv97E3SSqxCi57KZZEqjj1YJI4mhuSpZcxSDlAPkHpjVY5W+JZFz6aOc6w0nrfxoQnzgn9blPYbFjQMPeuH9UD3/mFJVHDdYyTN2TdMI9MEYgk3QLe3x7AG0BBLtJymZVVaT8Z2QDU0uDN822o8zYaKmGi6oIn8X28xg8rkXxLvK0aV3njBgt4wo3MTOpyLzgfZ7gijD8zFNOQm6cp3wTG9zP0dU/8oSpCEwMuQE+ow6z1/zy78WVsdpJtwvAVV39SGH9gv1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1vhqXXoL1TcAptu8hklD9f7Mygmk0JpMpfWPRo/8II=;
 b=kodjxvYUa7+XiJiyW7gXF9H/McqOLru4SJjoJ0ny/uriQEwB2CyaWOn43lbX9roBDPrZsecnC3nzzjIub5jXlYCzdJhlFInRafJICHji3rZJkJ4umPec/keddT+rDUcZLuH5HZDlimcLnh7QGjthtpHaI1KoF2sHUXLVF/bNu/9npPg4oGbw7DpRlqN5mYPfQryRhnU3P9A6Fj3NrVn27D8aDPdhyLGamoFtiMgxP1P7CdquxB9K4cLPsxLg3op5COlqAkeXAOE/DwMjkQVuXS+k0XEgF8pnXBFHIn8f1vnVpTgI9U1UpsVzrTuHpH1IpPNjytEB45bTPqj4q+TD3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=utah.edu; dmarc=pass action=none header.from=utah.edu;
 dkim=pass header.d=utah.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=UofUtah.onmicrosoft.com; s=selector2-UofUtah-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1vhqXXoL1TcAptu8hklD9f7Mygmk0JpMpfWPRo/8II=;
 b=KK/p9UNOAbFdZtwWH9SKm0q/iH6drH1RI/9BlA7rI0q8IDhSsbXr0WPeuosL6c4fChtYzAU2yrQ1Z5hRbIqZHuOhiyd4AE/j/lZ776706p6+rNpcWeKXDiybE0HP9mp8RES2DFQUpd+r3m2JCRLxvFleQGnqWLnWxt0JicxB9zg=
Received: from DM5PR11MB0057.namprd11.prod.outlook.com (2603:10b6:4:6b::12) by
 CY5PR11MB6414.namprd11.prod.outlook.com (2603:10b6:930:36::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.28; Mon, 12 Jun 2023 18:48:09 +0000
Received: from DM5PR11MB0057.namprd11.prod.outlook.com
 ([fe80::5119:1550:791d:b329]) by DM5PR11MB0057.namprd11.prod.outlook.com
 ([fe80::5119:1550:791d:b329%4]) with mapi id 15.20.6455.034; Mon, 12 Jun 2023
 18:48:09 +0000
From: Khagan Karimov <Khagan.karimov@utah.edu>
To: "xiang@kernel.org" <xiang@kernel.org>, "chao@kernel.org"
	<chao@kernel.org>, "huyue2@coolpad.com" <huyue2@coolpad.com>,
	"jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
	"linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: general protection fault in erofs_bread
Thread-Topic: general protection fault in erofs_bread
Thread-Index: AQHZnV0TN+cdbRY560GK6gjyFkqXVw==
Date: Mon, 12 Jun 2023 18:48:09 +0000
Message-ID: <DM5PR11MB005734E7E3DA4F3C588D207AE954A@DM5PR11MB0057.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=utah.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR11MB0057:EE_|CY5PR11MB6414:EE_
x-ms-office365-filtering-correlation-id: 1570b24a-f8ff-4171-fb19-08db6b759113
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YVZx8ODm39Y1jrE5V3Yat7YD5T+QwZNfV5wA1HqXXdKuUID8z12OqzDv8lvB9Coc3niAyUSDcRDWPKAU7vYv/lBB29KmIK/Xp0L5wuENgOJnK+XeuvFe7EbCFXJ4qwoo5a2WJMDacC4FxAlkEbgX0xEO7vpkAUdA0zxkn0eWASqc58uz+J/b7xjAtmk6ee/ppmRzjina2fQL2USl394S27t835FLmiG1lqIAV4Q4x4HYulFeSdo44XemBJglz5QF1V5cengpDyEctJKEMXXQgOoBjJceSSJGtJ+w6XFv+bEL2TH0xzO6+MQj05S0cuoDQw2mtQ2WQJD8DejiJrdIjdCjWo1ZwjJW1BiXYvcrFtNRuThEOP1BJ/lxz4d6SEG3IJLpioiSDKiJC2NrHO5zKSyHW7PUGS6zbwtqurkVJwZSmY/55hYUwnMnakraCJFuVBR9BgpKJHfm1cAHvLfycXFjPce2aT84u+58HQEp/D3MywuOw00kXH+EZyEfbigrc/i/g6jPUS9qfDloB4CCldMMlFzjI0uzv/sJAlT3e5Liel6mLldyOjO2STSH/tY31GQBESdipjdjwp4JR9aWFuyoYlnvagelfOSrEQr9/LA7hpyivXhbrHAq9g8e4LwinJQO7ELrc/5MQr0rjGTlZSxeEdM9vlzO+tDDGQ9BHt8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB0057.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(1690799014)(451199021)(41300700001)(45080400002)(2906002)(478600001)(75432002)(33656002)(1015004)(7696005)(966005)(71200400001)(166002)(38070700005)(26005)(38100700002)(9686003)(6506007)(122000001)(86362001)(186003)(786003)(316002)(4326008)(91956017)(83380400001)(5660300002)(8676002)(19627405001)(8936002)(76116006)(66946007)(110136005)(66476007)(64756008)(66556008)(66446008)(52536014)(84970400001)(55016003)(5930299015)(15398625002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XP05k69DdNqDxT0W/WRCCNT0TEzTCCbwgD1dbvsxOnrz5gvuaWE5znNX5P?=
 =?iso-8859-1?Q?UYDChS/seKzaiaFxwqNkhSuuTbIKZ6hPuYlOHZGGX982m8JDL88YHs6xO6?=
 =?iso-8859-1?Q?wTKi3+xmn5ZMbp2afDQekzLtxFoGVEsr9+bNl1X7GoLVkGRPrWXwHTxlWQ?=
 =?iso-8859-1?Q?7ZNDcTYyafuhPh9C+iqktwVUOx7aOgjqUVKaMpl7MlAubxeotzb2E68mDo?=
 =?iso-8859-1?Q?8xW+G4fmpXFSwmJpyhAsVloeXTGvQq65/O79Qe+85wRgicCweSIggOkAMJ?=
 =?iso-8859-1?Q?lOg3MfKPxiCdc3u/UjxHUZqONfIoMfRV2jBrw6FtdXOLdp4Tkl38XmNAVF?=
 =?iso-8859-1?Q?wIFwnDcYUSfKiyvldghV4qxwjX9bAEsBZBe6lOpSi6gBIGyzi6Glt01njl?=
 =?iso-8859-1?Q?4rXvVH3WaDajhGDiNRAW8cBhUopi+JZ8Jdc9hbwMwZ4C+abF0lORIVhfe7?=
 =?iso-8859-1?Q?nmfODGkpFJ9CXjBuSVOUUAwoF1ECZVi5S7Xf9VaFe/5bZMI/t7zmHgBTi6?=
 =?iso-8859-1?Q?8aJwCUQKm3Gn4Fb76prbESCLHLNhMf8EKkKkFVg8p0Z6aEk2OUbRk3xWUW?=
 =?iso-8859-1?Q?PpkvMGlp3tY3ElO2ZwNzhI8kj2eEyPYoTX8egxdXRnllqOpPnmqnCyFb5N?=
 =?iso-8859-1?Q?aHikW74+gUZHpNpaAp3O9t3o4XZpieoZ1J80k5BExIASW1pDjCMYsc1B/T?=
 =?iso-8859-1?Q?dKb270pLaqVj5J5Ub4u7gxCmnI2K1x4NwqIb2MwLjtwaBWG/oDugEhyxBN?=
 =?iso-8859-1?Q?0iQGxADOcOxRAgyvA1ZMhSS7ezI8a6ybBnIapXEZ6UAn5WwmCt7FYOBNVA?=
 =?iso-8859-1?Q?bSDyTQAbHNe1HWZuyuUFpKpp6LHiy3yw77uCJehwRKP6HPp+QNW13vgp5A?=
 =?iso-8859-1?Q?l/yNwuKfqoRa/fFr6U8mlq0ctGgwNVm9wJD/Wiz7ItMZQPGVWWXwXyZLJm?=
 =?iso-8859-1?Q?GdMfl7U70lM9xNcPSwpMgQcIxPM161KqXE3PAhG+ACQHbdI6XDD14qOgLE?=
 =?iso-8859-1?Q?z70yjYhjvb5hPnZvkUoN31b8Kkr50PeZNl8v32OEouHkqnOUflGuTZ7+FB?=
 =?iso-8859-1?Q?8cpP7ttOpjCDdqbuRzywiEU57UOkAsZ/P47kJxVPRRNAXzCatFPsNfIcKp?=
 =?iso-8859-1?Q?7kSZzy2CHb1ijtO9NTqwy+vd9IaRKGE06lJ5hlAwn9W2reuxp7MHKczPyM?=
 =?iso-8859-1?Q?wt4/dVBYYyUH00EAEokH00FUuAKgVFzTjAZLwFhZW8BfJq6TF0ZDCRfqe2?=
 =?iso-8859-1?Q?ubjho6Yp5NxnSx2jpJoeN1UCONglHg9EdnX0gpLsI8tAZHBPUil+wEHj9X?=
 =?iso-8859-1?Q?q/uL11qIgdbM7hPwMDW1TlPE4xskiEYcovcn0GXWlzecHv63f6qatUpQwH?=
 =?iso-8859-1?Q?UFVCxSRlLaNBM4yO7m97zNng637n4ABtYxwMYxfExgIHNwme4r2VtH6blK?=
 =?iso-8859-1?Q?VapZLxkvHf82d6MmX1y6eI0kk0HS3wqmGV9P3uT8qyJ1m//QdILE1zb9Cv?=
 =?iso-8859-1?Q?sGmOXjiY5PReQ4/sJL+ZlMn57U9mbF1y2jIfH8T/7uBGIf7TON9qT/S1Gt?=
 =?iso-8859-1?Q?YR0xeaLJbQB8LMDMynbfUJKKyRRlpWhmBLq2naIJ+Xt7sNU9fWOBseBhW9?=
 =?iso-8859-1?Q?aFANhpze7TYNDK3pGGOVWj11qxYWwk7Ji1?=
Content-Type: multipart/alternative;
	boundary="_000_DM5PR11MB005734E7E3DA4F3C588D207AE954ADM5PR11MB0057namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB0057.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1570b24a-f8ff-4171-fb19-08db6b759113
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 18:48:09.1841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5217e0e7-539d-4563-b1bf-7c6dcf074f91
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HtLQhmiztrD8KZcFjFQNFnKWODWK1dzUuPpaLlU/5/caHOYf7uD6STn4UoPLuJyWBCxPeWfD2+aGCeAPNuS2sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6414
X-OriginatorOrg: utah.edu
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
Cc: "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--_000_DM5PR11MB005734E7E3DA4F3C588D207AE954ADM5PR11MB0057namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Good day,


Dear Maintainers,


I found the following bug:



Kernel branch: 6.3.0-next-20230426

Kernel config: https://drive.google.com/file/d/1KU1ivdc6axWGXqmaODg5wYNJZ4v=
7p75j/view?usp=3Dsharing

C reproducer: https://drive.google.com/file/d/14qxiXna1l9BLxDH2Ozo6oebnhjbN=
i06e/view?usp=3Dsharing




loop4: detected capacity change from 0 to 16

erofs: (device loop4): EXPERIMENTAL compressed fragments feature in use. Us=
e at your own risk!

erofs: (device loop4): EXPERIMENTAL global deduplication feature in use. Us=
e at your own risk!

general protection fault, probably for non-canonical address 0xdffffc000000=
0019: 0000 [#1] PREEMPT SMP KASAN

KASAN: null-ptr-deref in range [0x00000000000000c8-0x00000000000000cf]

CPU: 6 PID: 14033 Comm: syz-executor.4 Not tainted 6.3.0-next-20230426 #1

Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014

RIP: 0010:erofs_bread+0x56/0x6d0 fs/erofs/data.c:38

Code: 48 c1 ea 03 80 3c 02 00 0f 85 17 06 00 00 48 b8 00 00 00 00 00 fc ff =
df 4c 8b 23 49 8d bc 24 ca 00 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 8=
9 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 84 05 00 00

RSP: 0018:ffffc90003f9f980 EFLAGS: 00010212

RAX: dffffc0000000000 RBX: ffffc90003f9faf8 RCX: ffffc9001350c000

RDX: 0000000000000019 RSI: ffffffff83b7198f RDI: 00000000000000ca

RBP: 0000000000000000 R08: 0000000000000001 R09: 000000000000003f

R10: 000000000000000c R11: 000000000008c001 R12: 0000000000000000

R13: 0000000000000001 R14: ffff888079bfa000 R15: ffff888079bfa000

FS:  00007f5338e33700(0000) GS:ffff888119f00000(0000) knlGS:000000000000000=
0

CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

CR2: 00007f5337c61c40 CR3: 0000000045e57000 CR4: 0000000000350ee0

Call Trace:

 <TASK>

 erofs_read_metadata+0xbb/0x490 fs/erofs/super.c:137

 erofs_xattr_prefixes_init+0x3b1/0x590 fs/erofs/xattr.c:684

 erofs_fc_fill_super+0x1732/0x2a70 fs/erofs/super.c:825

 get_tree_bdev+0x44a/0x770 fs/super.c:1303

 vfs_get_tree+0x8d/0x350 fs/super.c:1510

 do_new_mount fs/namespace.c:3039 [inline]

 path_mount+0x675/0x1e30 fs/namespace.c:3369

 do_mount fs/namespace.c:3382 [inline]

 __do_sys_mount fs/namespace.c:3591 [inline]

 __se_sys_mount fs/namespace.c:3568 [inline]

 __x64_sys_mount+0x283/0x300 fs/namespace.c:3568

 do_syscall_x64 arch/x86/entry/common.c:50 [inline]

 do_syscall_64+0x39/0x80 arch/x86/entry/common.c:80

 entry_SYSCALL_64_after_hwframe+0x63/0xcd

RIP: 0033:0x7f5337c9176e

Code: 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 =
00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48

RSP: 002b:00007f5338e32a08 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5

RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f5337c9176e

RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f5338e32a60

RBP: 00007f5338e32aa0 R08: 00007f5338e32aa0 R09: 0000000020000000

R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000

R13: 0000000020000100 R14: 00007f5338e32a60 R15: 00000000200108a0

 </TASK>

Modules linked in:

---[ end trace 0000000000000000 ]---

RIP: 0010:erofs_bread+0x56/0x6d0 fs/erofs/data.c:38

Code: 48 c1 ea 03 80 3c 02 00 0f 85 17 06 00 00 48 b8 00 00 00 00 00 fc ff =
df 4c 8b 23 49 8d bc 24 ca 00 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 8=
9 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 84 05 00 00

RSP: 0018:ffffc90003f9f980 EFLAGS: 00010212

RAX: dffffc0000000000 RBX: ffffc90003f9faf8 RCX: ffffc9001350c000

RDX: 0000000000000019 RSI: ffffffff83b7198f RDI: 00000000000000ca

RBP: 0000000000000000 R08: 0000000000000001 R09: 000000000000003f

R10: 000000000000000c R11: 000000000008c001 R12: 0000000000000000

R13: 0000000000000001 R14: ffff888079bfa000 R15: ffff888079bfa000

FS:  00007f5338e33700(0000) GS:ffff888119f00000(0000) knlGS:000000000000000=
0

CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

CR2: 00007f5337c61c40 CR3: 0000000045e57000 CR4: 0000000000350ee0

----------------

Code disassembly (best guess):

   0:   48 c1 ea 03             shr    $0x3,%rdx

   4:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1)

   8:   0f 85 17 06 00 00       jne    0x625

   e:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax

  15:   fc ff df

  18:   4c 8b 23                mov    (%rbx),%r12

  1b:   49 8d bc 24 ca 00 00    lea    0xca(%r12),%rdi

  22:   00

  23:   48 89 fa                mov    %rdi,%rdx

  26:   48 c1 ea 03             shr    $0x3,%rdx

* 2a:   0f b6 04 02             movzbl (%rdx,%rax,1),%eax <-- trapping inst=
ruction

  2e:   48 89 fa                mov    %rdi,%rdx

  31:   83 e2 07                and    $0x7,%edx

  34:   38 d0                   cmp    %dl,%al

  36:   7f 08                   jg     0x40

  38:   84 c0                   test   %al,%al

  3a:   0f 85 84 05 00 00       jne    0x5c4


Thank you very much!


Best Regards,


[Block U Logo]  Khagan Karimov (He/His/Him)
Ph.D. student | Security Researcher
Kahlert School of Computing, The University of Utah
meritpages.com/khagan_karimov
khagan.net


--_000_DM5PR11MB005734E7E3DA4F3C588D207AE954ADM5PR11MB0057namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
Good day,</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue';min=
-height:15.0px">
<br class=3D"ContentPasted0">
</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
Dear Maintainers,</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue';min=
-height:15.0px">
<br class=3D"ContentPasted0">
</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
I found the following bug:</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue';min=
-height:15.0px">
<br class=3D"ContentPasted0">
</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue';min=
-height:15.0px">
<br class=3D"ContentPasted0">
</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
Kernel branch: 6.3.0-next-20230426</p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-weight: normal; font-stretch: normal; font-size: 13px; line-height: norma=
l; font-family: &quot;Helvetica Neue&quot;; color: rgb(220, 161, 13);">
<span style=3D"color: rgb(0, 0, 0);" class=3D"ContentPasted0">Kernel config=
:&nbsp;<a href=3D"https://drive.google.com/file/d/1KU1ivdc6axWGXqmaODg5wYNJ=
Z4v7p75j/view?usp=3Dsharing" class=3D"ContentPasted0 OWAAutoLink ContentPas=
ted1" style=3D"margin: 0px; pointer-events: auto;" id=3D"OWA7f3fec28-eb61-1=
c53-8702-7e69278662f1" contenteditable=3D"true">https://drive.google.com/fi=
le/d/1KU1ivdc6axWGXqmaODg5wYNJZ4v7p75j/view?usp=3Dsharing</a></span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-weight: normal; font-stretch: normal; font-size: 13px; line-height: norma=
l; font-family: &quot;Helvetica Neue&quot;; color: rgb(220, 161, 13);">
<span style=3D"color: rgb(0, 0, 0);" class=3D"ContentPasted0"><span style=
=3D"text-decoration: none; display: inline !important; color: rgb(0, 0, 0);=
 background-color: rgb(255, 255, 255);">C reproducer:&nbsp;</span><a href=
=3D"https://drive.google.com/file/d/14qxiXna1l9BLxDH2Ozo6oebnhjbNi06e/view?=
usp=3Dsharing" class=3D"ContentPasted0 OWAAutoLink" id=3D"OWA5407ca50-e924-=
14c6-684c-cdd55cf1e94b">https://drive.google.com/file/d/14qxiXna1l9BLxDH2Oz=
o6oebnhjbNi06e/view?usp=3Dsharing</a></span></p>
<p style=3D"margin: 0px; font-style: normal; font-variant-caps: normal; fon=
t-weight: normal; font-stretch: normal; font-size: 13px; line-height: norma=
l; font-family: &quot;Helvetica Neue&quot;; color: rgb(220, 161, 13);">
<span style=3D"color: rgb(0, 0, 0);" class=3D"ContentPasted0">&nbsp;</span>=
</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue';min=
-height:15.0px">
<br class=3D"ContentPasted0">
</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
loop4: detected capacity change from 0 to 16</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
erofs: (device loop4): EXPERIMENTAL compressed fragments feature in use. Us=
e at your own risk!</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
erofs: (device loop4): EXPERIMENTAL global deduplication feature in use. Us=
e at your own risk!</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
general protection fault, probably for non-canonical address 0xdffffc000000=
0019: 0000 [#1] PREEMPT SMP KASAN</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
KASAN: null-ptr-deref in range [0x00000000000000c8-0x00000000000000cf]</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
CPU: 6 PID: 14033 Comm: syz-executor.4 Not tainted 6.3.0-next-20230426 #1</=
p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/=
2014</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
RIP: 0010:erofs_bread+0x56/0x6d0 fs/erofs/data.c:38</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
Code: 48 c1 ea 03 80 3c 02 00 0f 85 17 06 00 00 48 b8 00 00 00 00 00 fc ff =
df 4c 8b 23 49 8d bc 24 ca 00 00 00 48 89 fa 48 c1 ea 03 &lt;0f&gt; b6 04 0=
2 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 84 05 00 00</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
RSP: 0018:ffffc90003f9f980 EFLAGS: 00010212</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
RAX: dffffc0000000000 RBX: ffffc90003f9faf8 RCX: ffffc9001350c000</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
RDX: 0000000000000019 RSI: ffffffff83b7198f RDI: 00000000000000ca</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
RBP: 0000000000000000 R08: 0000000000000001 R09: 000000000000003f</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
R10: 000000000000000c R11: 000000000008c001 R12: 0000000000000000</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
R13: 0000000000000001 R14: ffff888079bfa000 R15: ffff888079bfa000</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
FS:<span class=3D"Apple-converted-space ContentPasted0">&nbsp; </span>00007=
f5338e33700(0000) GS:ffff888119f00000(0000) knlGS:0000000000000000</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
CS:<span class=3D"Apple-converted-space ContentPasted0">&nbsp; </span>0010 =
DS: 0000 ES: 0000 CR0: 0000000080050033</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
CR2: 00007f5337c61c40 CR3: 0000000045e57000 CR4: 0000000000350ee0</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
Call Trace:</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp;</span>&lt;TASK&=
gt;</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp;</span>erofs_rea=
d_metadata+0xbb/0x490 fs/erofs/super.c:137</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp;</span>erofs_xat=
tr_prefixes_init+0x3b1/0x590 fs/erofs/xattr.c:684</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp;</span>erofs_fc_=
fill_super+0x1732/0x2a70 fs/erofs/super.c:825</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp;</span>get_tree_=
bdev+0x44a/0x770 fs/super.c:1303</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp;</span>vfs_get_t=
ree+0x8d/0x350 fs/super.c:1510</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp;</span>do_new_mo=
unt fs/namespace.c:3039 [inline]</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp;</span>path_moun=
t+0x675/0x1e30 fs/namespace.c:3369</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp;</span>do_mount =
fs/namespace.c:3382 [inline]</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp;</span>__do_sys_=
mount fs/namespace.c:3591 [inline]</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp;</span>__se_sys_=
mount fs/namespace.c:3568 [inline]</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp;</span>__x64_sys=
_mount+0x283/0x300 fs/namespace.c:3568</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp;</span>do_syscal=
l_x64 arch/x86/entry/common.c:50 [inline]</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp;</span>do_syscal=
l_64+0x39/0x80 arch/x86/entry/common.c:80</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp;</span>entry_SYS=
CALL_64_after_hwframe+0x63/0xcd</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
RIP: 0033:0x7f5337c9176e</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
Code: 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 =
00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 &lt;48&gt; 3d 01 f=
0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
RSP: 002b:00007f5338e32a08 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f5337c9176e</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f5338e32a60</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
RBP: 00007f5338e32aa0 R08: 00007f5338e32aa0 R09: 0000000020000000</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000020000000</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
R13: 0000000020000100 R14: 00007f5338e32a60 R15: 00000000200108a0</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp;</span>&lt;/TASK=
&gt;</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
Modules linked in:</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
---[ end trace 0000000000000000 ]---</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
RIP: 0010:erofs_bread+0x56/0x6d0 fs/erofs/data.c:38</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
Code: 48 c1 ea 03 80 3c 02 00 0f 85 17 06 00 00 48 b8 00 00 00 00 00 fc ff =
df 4c 8b 23 49 8d bc 24 ca 00 00 00 48 89 fa 48 c1 ea 03 &lt;0f&gt; b6 04 0=
2 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 84 05 00 00</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
RSP: 0018:ffffc90003f9f980 EFLAGS: 00010212</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
RAX: dffffc0000000000 RBX: ffffc90003f9faf8 RCX: ffffc9001350c000</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
RDX: 0000000000000019 RSI: ffffffff83b7198f RDI: 00000000000000ca</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
RBP: 0000000000000000 R08: 0000000000000001 R09: 000000000000003f</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
R10: 000000000000000c R11: 000000000008c001 R12: 0000000000000000</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
R13: 0000000000000001 R14: ffff888079bfa000 R15: ffff888079bfa000</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
FS:<span class=3D"Apple-converted-space ContentPasted0">&nbsp; </span>00007=
f5338e33700(0000) GS:ffff888119f00000(0000) knlGS:0000000000000000</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
CS:<span class=3D"Apple-converted-space ContentPasted0">&nbsp; </span>0010 =
DS: 0000 ES: 0000 CR0: 0000000080050033</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
CR2: 00007f5337c61c40 CR3: 0000000045e57000 CR4: 0000000000350ee0</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
----------------</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
Code disassembly (best guess):</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp;&nbsp; </span>0:=
 <span class=3D"Apple-converted-space ContentPasted0">
&nbsp; </span>48 c1 ea 03 <span class=3D"Apple-converted-space ContentPaste=
d0">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
</span>shr<span class=3D"Apple-converted-space ContentPasted0">&nbsp; &nbsp=
; </span>$0x3,%rdx</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp;&nbsp; </span>4:=
 <span class=3D"Apple-converted-space ContentPasted0">
&nbsp; </span>80 3c 02 00 <span class=3D"Apple-converted-space ContentPaste=
d0">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
</span>cmpb <span class=3D"Apple-converted-space ContentPasted0">&nbsp; </s=
pan>$0x0,(%rdx,%rax,1)</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp;&nbsp; </span>8:=
 <span class=3D"Apple-converted-space ContentPasted0">
&nbsp; </span>0f 85 17 06 00 00 <span class=3D"Apple-converted-space Conten=
tPasted0">&nbsp; &nbsp; &nbsp;
</span>jne<span class=3D"Apple-converted-space ContentPasted0">&nbsp; &nbsp=
; </span>0x625</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp;&nbsp; </span>e:=
 <span class=3D"Apple-converted-space ContentPasted0">
&nbsp; </span>48 b8 00 00 00 00 00<span class=3D"Apple-converted-space Cont=
entPasted0">&nbsp; &nbsp;
</span>movabs $0xdffffc0000000000,%rax</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp; </span>15: <spa=
n class=3D"Apple-converted-space ContentPasted0">
&nbsp; </span>fc ff df</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp; </span>18: <spa=
n class=3D"Apple-converted-space ContentPasted0">
&nbsp; </span>4c 8b 23<span class=3D"Apple-converted-space ContentPasted0">=
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
</span>mov<span class=3D"Apple-converted-space ContentPasted0">&nbsp; &nbsp=
; </span>(%rbx),%r12</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp; </span>1b: <spa=
n class=3D"Apple-converted-space ContentPasted0">
&nbsp; </span>49 8d bc 24 ca 00 00<span class=3D"Apple-converted-space Cont=
entPasted0">&nbsp; &nbsp;
</span>lea<span class=3D"Apple-converted-space ContentPasted0">&nbsp; &nbsp=
; </span>0xca(%r12),%rdi</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp; </span>22: <spa=
n class=3D"Apple-converted-space ContentPasted0">
&nbsp; </span>00</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp; </span>23: <spa=
n class=3D"Apple-converted-space ContentPasted0">
&nbsp; </span>48 89 fa<span class=3D"Apple-converted-space ContentPasted0">=
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
</span>mov<span class=3D"Apple-converted-space ContentPasted0">&nbsp; &nbsp=
; </span>%rdi,%rdx</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp; </span>26: <spa=
n class=3D"Apple-converted-space ContentPasted0">
&nbsp; </span>48 c1 ea 03 <span class=3D"Apple-converted-space ContentPaste=
d0">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
</span>shr<span class=3D"Apple-converted-space ContentPasted0">&nbsp; &nbsp=
; </span>$0x3,%rdx</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
* 2a: <span class=3D"Apple-converted-space ContentPasted0">&nbsp; </span>0f=
 b6 04 02 <span class=3D"Apple-converted-space ContentPasted0">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </span>movzbl (%rdx,%rax,1),%eax =
&lt;-- trapping instruction</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp; </span>2e: <spa=
n class=3D"Apple-converted-space ContentPasted0">
&nbsp; </span>48 89 fa<span class=3D"Apple-converted-space ContentPasted0">=
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
</span>mov<span class=3D"Apple-converted-space ContentPasted0">&nbsp; &nbsp=
; </span>%rdi,%rdx</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp; </span>31: <spa=
n class=3D"Apple-converted-space ContentPasted0">
&nbsp; </span>83 e2 07<span class=3D"Apple-converted-space ContentPasted0">=
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
</span>and<span class=3D"Apple-converted-space ContentPasted0">&nbsp; &nbsp=
; </span>$0x7,%edx</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp; </span>34: <spa=
n class=3D"Apple-converted-space ContentPasted0">
&nbsp; </span>38 d0 <span class=3D"Apple-converted-space ContentPasted0">&n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
</span>cmp<span class=3D"Apple-converted-space ContentPasted0">&nbsp; &nbsp=
; </span>%dl,%al</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp; </span>36: <spa=
n class=3D"Apple-converted-space ContentPasted0">
&nbsp; </span>7f 08 <span class=3D"Apple-converted-space ContentPasted0">&n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
</span>jg <span class=3D"Apple-converted-space ContentPasted0">&nbsp; &nbsp=
; </span>0x40</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp; </span>38: <spa=
n class=3D"Apple-converted-space ContentPasted0">
&nbsp; </span>84 c0 <span class=3D"Apple-converted-space ContentPasted0">&n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
</span>test <span class=3D"Apple-converted-space ContentPasted0">&nbsp; </s=
pan>%al,%al</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
<span class=3D"Apple-converted-space ContentPasted0">&nbsp; </span>3a: <spa=
n class=3D"Apple-converted-space ContentPasted0">
&nbsp; </span>0f 85 84 05 00 00 <span class=3D"Apple-converted-space Conten=
tPasted0">&nbsp; &nbsp; &nbsp;
</span>jne<span class=3D"Apple-converted-space ContentPasted0">&nbsp; &nbsp=
; </span>0x5c4</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue';min=
-height:15.0px">
<br class=3D"ContentPasted0">
</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue'" cl=
ass=3D"ContentPasted0">
Thank you very much!</p>
<p style=3D"margin:0.0px 0.0px 0.0px 0.0px;font:13.0px 'Helvetica Neue';min=
-height:15.0px">
<br>
</p>
</div>
<div class=3D"elementToProof">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<div><span style=3D"color: rgb(51, 51, 51);"><b><i>Best Regards,</i></b></s=
pan><br>
</div>
<div></div>
<div><br>
</div>
<div><br>
</div>
<div>
<table id=3D"tableSelected0" width=3D"100%">
<tbody>
<tr>
<td style=3D"padding:0" width=3D"110" valign=3D"top"><img alt=3D"Block U Lo=
go" style=3D"width: 116px; height: 80px; max-width: initial;" width=3D"116"=
 height=3D"80" src=3D"https://digital.utah.edu/wp-content/uploads/sites/2/2=
022/03/blockU.gif"></td>
<td style=3D"padding:0" valign=3D"top"><strong><span style=3D"font-size: 14=
px; font-family: Arial; color: rgb(102, 102, 102);">Khagan Karimov (<strong=
><em><span style=3D"font-size:12px">He/His/Him</span></em></strong>)&nbsp;<=
/span></strong><br>
<strong><em></em></strong><strong><em><span style=3D"font-size: 12px; font-=
family: Arial; color: rgb(102, 102, 102);">Ph.D. student | Security Researc=
her &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</span></em></str=
ong>
<br>
<span style=3D"font-size: 12px; font-family: Arial; color: rgb(128, 128, 12=
8);">Kahlert School of Computing,
<span>The University of Utah</span></span> <br>
<span style=3D"font-size: 12px; font-family: Arial; color: rgb(128, 128, 12=
8);"></span><font face=3D"Arial" style=3D"color: rgb(128, 128, 128);"><span=
 style=3D"font-size: 12px;">meritpages.com/khagan_karimov</span></font><br>
<font face=3D"Arial" style=3D"color: rgb(128, 128, 128);"><span style=3D"ca=
ret-color: rgb(128, 128, 128); font-size: 12px;">khagan.net</span></font><b=
r>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR11MB005734E7E3DA4F3C588D207AE954ADM5PR11MB0057namp_--
