Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DC23B79DC64
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Sep 2023 01:03:16 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=ucf.onmicrosoft.com header.i=@ucf.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-ucf-onmicrosoft-com header.b=Ph91jvpP;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RlfJL5PhVz3c12
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Sep 2023 09:03:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=ucf.onmicrosoft.com header.i=@ucf.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-ucf-onmicrosoft-com header.b=Ph91jvpP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ucf.edu (client-ip=2a01:111:f400:fe5b::704; helo=nam12-bn8-obe.outbound.protection.outlook.com; envelope-from=sanan.hasanov@ucf.edu; receiver=lists.ozlabs.org)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20704.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::704])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RlfJD2KQvz2yVp
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Sep 2023 09:03:06 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpEx16SQgsc22w/LsWNdVJobD5MAFHfIJFSe3yX5qQvSuH2CWF9taFFI4VmZy4NamjZs8redCe8WUXHH0ysRlB/pE3ZHOE+TqMGOggVLxxrjlTsj9kYTN+R9TS4bgzkceSBh3u40+D6fwmWOoGqUONcyBcdPrgviDXn7mZ2Jwxv4+I5ZGl8aRWu8sT9+OzNywjN/wOXYWpfAO3KJR1njR0mDhbmLaTRsXZl+8MmCWd3vN86v9yQG6c+3BO1MkJL5pc3qCL/zl7VN9wq5nf1z6zc67tSuF+APcRkpzlLNKr9jTB+jyUOtLt3YbYO9YD8XK3QhrWLi/lTt9k6uVVYD1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T6aGfv9XccpTOFcnobMT7Ga9FLpEj9aVroPQCmYKv6s=;
 b=g+yyEPi1SFWeXs+mFDGAb5OadNDwZm1WM2NqJrVLWb59EHtYRr98Z77tOWML7wf1WXIHcZ6M36HLAiscTQ9uUgo16J76bhkXco6cR0bfklSvbWpvCzlFuxqoSavOzZc8k0VrhMalKDDrYdgMF+fu/kZPNMybIBuDiqvA/YPBkgCsTHI46ZM63U2vlYFbo/FicHpLThUqe0+8ApL7v/7/7VdvM0+NeIM/ZXC9DA2/SxiTClSjaWSohTjo1o0ahVDlq1ZlMQAZD1yuoAUiHIErtYhR6HUaojhOSxiqtb/ToFTfj6DzyPGZBgodil1IfsLq2h8o+5xLtxC6eMOpfOPifA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucf.edu; dmarc=pass action=none header.from=ucf.edu; dkim=pass
 header.d=ucf.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucf.onmicrosoft.com;
 s=selector2-ucf-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6aGfv9XccpTOFcnobMT7Ga9FLpEj9aVroPQCmYKv6s=;
 b=Ph91jvpP2VkaIsXwL6VSjNEBcS1rltRoUN38hLKphIBdnZSjcvIhBpxpvGzyX6Ski4MpAtO89G7cBKYMwzAM18kcCPkESMGeOrGVysC6L8qS5sFZ3w/R6SUF0uG/Mpb6MwddlXkwULtqElujhCCrPcYVPTbhR3jPWIvGmuzAAHc=
Received: from BL0PR11MB3106.namprd11.prod.outlook.com (2603:10b6:208:7a::11)
 by DS0PR11MB7531.namprd11.prod.outlook.com (2603:10b6:8:14a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 23:02:45 +0000
Received: from BL0PR11MB3106.namprd11.prod.outlook.com
 ([fe80::713d:6260:57c8:d3ce]) by BL0PR11MB3106.namprd11.prod.outlook.com
 ([fe80::713d:6260:57c8:d3ce%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 23:02:45 +0000
From: Sanan Hasanov <Sanan.Hasanov@ucf.edu>
To: "xiang@kernel.org" <xiang@kernel.org>, "chao@kernel.org"
	<chao@kernel.org>, "huyue2@coolpad.com" <huyue2@coolpad.com>,
	"jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
	"linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: kernel BUG in erofs_iget
Thread-Topic: kernel BUG in erofs_iget
Thread-Index: AQHZ4c3CaZLiRcWXh02rXkVu9YYPeA==
Date: Tue, 12 Sep 2023 23:02:45 +0000
Message-ID:  <BL0PR11MB3106CA52AA8E2978AF2756B6E1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucf.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3106:EE_|DS0PR11MB7531:EE_
x-ms-office365-filtering-correlation-id: ff960d5f-f090-40a8-eb4e-08dbb3e4607d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  v6tIMlj5EEWKL3IMd2oGXjDtGaZHDlmOzHuy44WreIbRDwfQrcOsKPL9jx9/4B5jazlekEhqPKFoYhfuoRi/ed4e+xirynXQhLct3OvXCt9LuZUTtt3zGdQaOQNdzst9f6yBJcKIsMdXChlguSOtgOYH08TfPA50RKcxq7uhuFzUiXiAhQ7BzsP7iTZ6k07JoYtG6xczMmFg337jiNiBnK6ZDd2AWhf17kIFJgdDshulWvw2tXXpH2acv6Z74ooco8LrlPiaEbXveMC4C2QoBF2IFWotULJ74xRmXugh10K4xQgPjlnBPakp/N+6wDlUwzvjQWib6ARnv97fo3FCP4tZa9WK/iyTiBqvYmkZCUB0xeeuPfyqG9KRaBMLWwIYRW7Xk0OvTHLU6dE8BvssyAtDYSowxUKGKkq4dMQoLA7Axzu+b9kwr0N/Ko2N5JJMLSzZQQ4sMpyBH2ZUKBiagclwS0POz3jb8lqglOecbkl2lnQxq56Lh0uGjgGs5rJGUxpwK6Uoraib6HSOaJrzNLDrSPOyNyEpDBhMd6lwkGF0QOK97ADPz95UT9KYLqVF7o9MU5mwPiIOXYjRGTF2NLckGttI+gPyaGq730afGotH0x/V1R79lLoumG1lT/8wOlAzi78bzyTK+Pp3788fM9M1M4YBIchv73NtYpgLhJM=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3106.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39850400004)(346002)(366004)(376002)(1800799009)(451199024)(186009)(122000001)(5930299018)(6506007)(7696005)(71200400001)(33656002)(75432002)(38070700005)(55016003)(38100700002)(478600001)(83380400001)(26005)(45080400002)(52536014)(86362001)(2906002)(9686003)(41300700001)(64756008)(966005)(76116006)(8936002)(8676002)(5660300002)(4326008)(110136005)(54906003)(786003)(66946007)(66446008)(316002)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?TkQ4ZmtXTW1RdkNEMXVaS2RBSFhNMlE4L3M1VGJMNldJVnFjYmF6THdpMjU2?=
 =?utf-8?B?bWMrWnVRZGhqR2I4ZkJ1alNGelRHeGExcFN3VmlmWkhxN28rKzdjV0Y5Mjg5?=
 =?utf-8?B?N29nQ3Naa1FReFdoZHlyOVMxanRpYUQ3YnFiZDdBdE0vVzJWRnhyYlh3eFQ3?=
 =?utf-8?B?LysvVldRUnNmRjNpT2sraG15QWdLaDBzbTlDSDdEd2FnRjFxd3owYUFJa3Ax?=
 =?utf-8?B?Q3NuM3BZZ09kc3BWdnJ6ekRDZkNyODRVVW05eVJuRzg2Z09scWFWclFLNDBB?=
 =?utf-8?B?R2pWVHFLcHdnaUg2Z1c3anF3cDYwWS8xRS94T0x5Y2wvTm9ZeXd0Y3E5dFc1?=
 =?utf-8?B?anNwYnBUM205R2paVDRreCtOTWNzZUlFK0l4endxNzFzYU5yRno0a0p2WmFM?=
 =?utf-8?B?U05GVGQrM1FNb2JjQjNObWdMdWFPUHdPZ09MTjcrZUxrMGZ3cjRrRjlUZ0pr?=
 =?utf-8?B?emRTWnVDTytTNXFmdllUTGRIdG5FYjV0NjZqaUJOY2lpTHpieVBIVWRFcXd4?=
 =?utf-8?B?TVZlb3g1MjliV3diTTBrbWw2YlZMcGVOSjA1aDZRb0thaFNPQklwQkVzcTFC?=
 =?utf-8?B?dmJnbFRNcG4vdHV3cTZKNjNDVUN1a2gyWTVGWFFHWlZCMTI1cEk3MG12OEhE?=
 =?utf-8?B?WUJQRDBsc2VrM2FiTkVwSFd4c2VPWlFURmVFWWZBZUVMM3YzUmxXMjB6T0I5?=
 =?utf-8?B?YXgzKzV5cGp5c2tPWVA0bzJ4MzIvMDB2SFFuS1l2WkRlRElCaWErN3IxUmYy?=
 =?utf-8?B?d09pRWwwVEhzdWlpbzhLR0tJM0llMFNTTmxySkovcjJ4Q2Q3QUJ5aGpSSkJx?=
 =?utf-8?B?aVJlQ0VpRlltanlTcFpDdjJNaExyUFdkTml1dktjVmJ4VWpEeGhyYUJRTmxx?=
 =?utf-8?B?Y1RrVFNuTEZGNUlpeEZXSllTQ3djeFRiN2Y4em1DQkVmb2p1TkJDNnlBZkRt?=
 =?utf-8?B?SXdMNUtRNTdZK1Yyb2QwSlJjTHN0SnE3U0lYcjJTNjVUdkgyY0RRMXE0RzJm?=
 =?utf-8?B?aWFvU0YxZW9qS01hSzlyYjF4WVVodVUxNG5hcGZ5a3VQWSs3SWZFMHN1dkhB?=
 =?utf-8?B?TFVDZnJMY2dXUlhnSDhvVUZHc3ZyK2hrQXVUVVZ2NjZUMHhYay8xVUF2a01H?=
 =?utf-8?B?MHZiZVFUUG1RVW13WWpnNlhsUEJlUnJhTGk5Nmo2QmhkUCtPQmFYTnJTcXhE?=
 =?utf-8?B?d0VaSXNSelE2S3ZRV1Z6SDUvMUNPaURhQ1IvbldNV1VYTkdTbUFhb2czR1lS?=
 =?utf-8?B?Mkl5UlpJS1lLTU54cHd0UEZSMy83NTJ5b3ltZkZqd1MrV2pVZ1JhL0ZsWWQ1?=
 =?utf-8?B?RXA0MUF6WHU1aW1aaXo3aW1jZE5WNVU3V2I2NnhRV3c1Vzc2bVhZVkRFMWx5?=
 =?utf-8?B?SUFiUWNzaXZqVFhCVVllU3hIRi9LUlQveklWeVo5RjJlVzNHUXBYaHgzbjlN?=
 =?utf-8?B?Zm51K21JRTd4UThxQ3pLeFJLa0E1aGx4NTBzN3ZBcGFUZ3VqT2NCZUY4UUwx?=
 =?utf-8?B?VWVzSjgyYUxBdjhoa2xvK2k2bkRZajB6ZDRZWi9mdFptTDJjZ21HOVVTMWg4?=
 =?utf-8?B?Y3Y1R1I3QU1QcXpmcE9WaDNNWkFTU3N2clRvYisvUTRaVmMzZjd5YjRrY0sz?=
 =?utf-8?B?SVZzOFlORUZqMDlZaGpOZWl0WElGL2tPMEhGMUtVcjBsOWZDbWJDcFpCRWZa?=
 =?utf-8?B?OUZtWHRXb2JKM21wYWNOZHdFOHQ3SE1ia2JhT1lQanhwdUwvMCtvN3grN3Yr?=
 =?utf-8?B?RkxQMVNsZG82Yk0ya05GMXM3M1hMQ0xLbU04YU9tSTEyT0dJcmNkTVlubThH?=
 =?utf-8?B?ajdHUFJ5U2hzUXBaVHFZZ09zd3J3dGZ5ZXVKYVNFS0pycEVJbm14ZGFLMHFD?=
 =?utf-8?B?M3NjWHA5UGkvTzFUNEJiKzNVMXc4bUMrRXBva2c2R0NlZUlUYmFEV2hzNTNT?=
 =?utf-8?B?anJ0SjlzMlVLeWZiNkZHMlhmZXh2RTl4MFFWeVd1WUJpTElRUXVHV1lCQ28w?=
 =?utf-8?B?NENCdmlORTIrRk5XbUllRllKNlJtQmN0YVBtRmp4SFZ3VzNWYS85NG9BTjNm?=
 =?utf-8?B?dnlDTXdoaGRoblB0NjhabXpsTlVyWlRMeUc5YlRDUU9kaW5MVGtNT251c1Fs?=
 =?utf-8?Q?Ojn4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ucf.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3106.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff960d5f-f090-40a8-eb4e-08dbb3e4607d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 23:02:45.5478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb932f15-ef38-42ba-91fc-f3c59d5dd1f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ccgE7nfeWfDG/NS/YaJ9pR8AUZfqymKYJWJ3q4zvBTeleT/VXkkYKVLzc9/z/gPEzjPtqeHRb4wEvicRnUclg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7531
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
Cc: "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>, "contact@pgazz.com" <contact@pgazz.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

R29vZCBkYXksIGRlYXIgbWFpbnRhaW5lcnMsCgpXZSBmb3VuZCBhIGJ1ZyB1c2luZyBhIG1vZGlm
aWVkIGtlcm5lbCBjb25maWd1cmF0aW9uIGZpbGUgdXNlZCBieSBzeXpib3QuCgpXZSBlbmhhbmNl
ZCB0aGUgY292ZXJhZ2Ugb2YgdGhlIGNvbmZpZ3VyYXRpb24gZmlsZSB1c2luZyBvdXIgdG9vbCwg
a2xvY2FsaXplci4KCktlcm5lbCBCcmFuY2g6IDYuMy4wLW5leHQtMjAyMzA0MjYKS2VybmVsIENv
bmZpZzogaHR0cHM6Ly9kcml2ZS5nb29nbGUuY29tL2ZpbGUvZC8xckdJS1dURWZvTWVkMEpMNWpX
RndzNEdKMFZOU1Zndzgvdmlldz91c3A9c2hhcmluZwpSZXByb2R1Y2VyOiBodHRwczovL2RyaXZl
Lmdvb2dsZS5jb20vZmlsZS9kLzFjZUFGY3g5aGhldnFfaXZETlBrWG1FR1lzcjI2eUI0Ti92aWV3
P3VzcD1zaGFyaW5nClRoYW5rIHlvdSEKCkJlc3QgcmVnYXJkcywKU2FuYW4gSGFzYW5vdgoKbG9v
cDM6IGRldGVjdGVkIGNhcGFjaXR5IGNoYW5nZSBmcm9tIDAgdG8gMTMxMDcyCmVyb2ZzOiAoZGV2
aWNlIGxvb3A3KTogZXJvZnNfcmVhZF9pbm9kZTogYm9ndXMgaV9tb2RlICgwKSBAIG5pZCA5Ci0t
LS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQpGMkZTLWZzIChsb29wMyk6IFVucmVj
b2duaXplZCBtb3VudCBvcHRpb24gIu+/ve+/ve+/ve+/vSIgb3IgbWlzc2luZyB2YWx1ZQprZXJu
ZWwgQlVHIGF0IGZzL2Vyb2ZzL2lub2RlLmM6MjAxIQppbnZhbGlkIG9wY29kZTogMDAwMCBbIzFd
IFBSRUVNUFQgU01QIEtBU0FOCkNQVTogMyBQSUQ6IDI0ODMyIENvbW06IHN5ei1leGVjdXRvci43
IE5vdCB0YWludGVkIDYuMy4wLW5leHQtMjAyMzA0MjYgIzEKSGFyZHdhcmUgbmFtZTogUUVNVSBT
dGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksIEJJT1MgMS4xNS4wLTEgMDQvMDEvMjAx
NApSSVA6IDAwMTA6ZXJvZnNfaWdldCsweDEzZGUvMHgyODkwCkNvZGU6IDAwIDBmIDg1IDE2IDEz
IDAwIDAwIDQ5IDhiIDdjIDI0IDI4IDQ5IDg5IGQ4IDQ0IDg5IGU5IDQ4IGM3IGMyIGEwIGVlIGU0
IDg4IDQ4IGM3IGM2IDQwIGYxIGU0IDg4IGU4IDQ3IGIxIGZmIGZmIGU4IGUyIDlmIDM1IGZlIDww
Zj4gMGIgNjYgNDEgODEgZmUgMDAgMTAgMGYgODQgMTUgZmYgZmYgZmYgZTkgNWYgZmYgZmYgZmYg
ZTggY2EgOWYKUlNQOiAwMDE4OmZmZmY4ODgwNTdkZTdhMDAgRUZMQUdTOiAwMDAxMDIxNgpSQVg6
IDAwMDAwMDAwMDAwMDE3MGEgUkJYOiAwMDAwMDAwMDAwMDAwMDA5IFJDWDogZmZmZmM5MDAwNjky
MTAwMAprb2JqZWN0OiAnbG9vcDAnICgwMDAwMDAwMDEwYzM0Zjk5KToga29iamVjdF91ZXZlbnRf
ZW52ClJEWDogMDAwMDAwMDAwMDA0MDAwMCBSU0k6IGZmZmZmZmZmODM1M2NiN2UgUkRJOiBmZmZm
ZmZmZjgxNmNhNzExClJCUDogZmZmZjg4ODA1N2RlN2I0OCBSMDg6IDAwMDAwMDAwMDAwMDAwMDUg
UjA5OiAwMDAwMDAwMDAwMDAwMDAwCmtvYmplY3Q6ICdsb29wMCcgKDAwMDAwMDAwMTBjMzRmOTkp
OiBrb2JqZWN0X3VldmVudF9lbnY6IHVldmVudF9zdXBwcmVzcyBjYXVzZWQgdGhlIGV2ZW50IHRv
IGRyb3AhClIxMDogMDAwMDAwMDA4MDAwMDAwMCBSMTE6IDAwMDAwMDAwMDA3YjhmNTggUjEyOiBm
ZmZmODg4MDQ1ZGVmNTkwCmxvb3AwOiBkZXRlY3RlZCBjYXBhY2l0eSBjaGFuZ2UgZnJvbSAwIHRv
IDUxMgprb2JqZWN0OiAnbG9vcDUnICgwMDAwMDAwMDk3N2M1ZDU2KToga29iamVjdF91ZXZlbnRf
ZW52CmtvYmplY3Q6ICdsb29wNScgKDAwMDAwMDAwOTc3YzVkNTYpOiBmaWxsX2tvYmpfcGF0aDog
cGF0aCA9ICcvZGV2aWNlcy92aXJ0dWFsL2Jsb2NrL2xvb3A1JwpSMTM6IDAwMDAwMDAwMDAwMDAw
MDAgUjE0OiAwMDAwMDAwMDAwMDAwMDAwIFIxNTogMDAwMDAwMDAwMDAwMDAwMAprb2JqZWN0OiAn
bG9vcDAnICgwMDAwMDAwMDEwYzM0Zjk5KToga29iamVjdF91ZXZlbnRfZW52CkZTOiAgMDAwMDdm
Yjc3Zjg1MjcwMCgwMDAwKSBHUzpmZmZmODg4MTFhMzgwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAw
MDAwMDAwMDAKQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAz
Mwprb2JqZWN0OiAnbG9vcDAnICgwMDAwMDAwMDEwYzM0Zjk5KToga29iamVjdF91ZXZlbnRfZW52
OiB1ZXZlbnRfc3VwcHJlc3MgY2F1c2VkIHRoZSBldmVudCB0byBkcm9wIQpDUjI6IDAwMDA3ZmI3
N2U2NjFjNDAgQ1IzOiAwMDAwMDAwMDU3Njk1MDAwIENSNDogMDAwMDAwMDAwMDM1MGVlMAprb2Jq
ZWN0OiAnbG9vcDQnICgwMDAwMDAwMGFiNTllYWQ2KToga29iamVjdF91ZXZlbnRfZW52CkNhbGwg
VHJhY2U6CmtvYmplY3Q6ICdsb29wNCcgKDAwMDAwMDAwYWI1OWVhZDYpOiBmaWxsX2tvYmpfcGF0
aDogcGF0aCA9ICcvZGV2aWNlcy92aXJ0dWFsL2Jsb2NrL2xvb3A0JwogPFRBU0s+CiBlcm9mc19m
Y19maWxsX3N1cGVyKzB4MTRlNS8weDI4ZTAKIGdldF90cmVlX2JkZXYrMHg0NDcvMHg3NzAKIGVy
b2ZzX2ZjX2dldF90cmVlKzB4MjEvMHgzMAogdmZzX2dldF90cmVlKzB4OTcvMHgzNzAKIHBhdGhf
bW91bnQrMHg2ZDMvMHgxZmIwCiBfX3g2NF9zeXNfbW91bnQrMHgyYjIvMHgzNDAKIGRvX3N5c2Nh
bGxfNjQrMHgzZi8weDkwCiBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3Mi8weGRj
ClJJUDogMDAzMzoweDdmYjc3ZTY5MTc2ZQpDb2RlOiA0OCBjNyBjMSBiOCBmZiBmZiBmZiBmNyBk
OCA2NCA4OSAwMSA0OCA4MyBjOCBmZiBjMyA2NiAyZSAwZiAxZiA4NCAwMCAwMCAwMCAwMCAwMCA5
MCBmMyAwZiAxZSBmYSA0OSA4OSBjYSBiOCBhNSAwMCAwMCAwMCAwZiAwNSA8NDg+IDNkIDAxIGYw
IGZmIGZmIDczIDAxIGMzIDQ4IGM3IGMxIGI4IGZmIGZmIGZmIGY3IGQ4IDY0IDg5IDAxIDQ4ClJT
UDogMDAyYjowMDAwN2ZiNzdmODUxYTA4IEVGTEFHUzogMDAwMDAyMDYgT1JJR19SQVg6IDAwMDAw
MDAwMDAwMDAwYTUKUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAyMDAwMDA4MCBS
Q1g6IDAwMDA3ZmI3N2U2OTE3NmUKUkRYOiAwMDAwMDAwMDIwMDAwMDAwIFJTSTogMDAwMDAwMDAy
MDAwMDEwMCBSREk6IDAwMDA3ZmI3N2Y4NTFhNjAKUkJQOiAwMDAwN2ZiNzdmODUxYWEwIFIwODog
MDAwMDdmYjc3Zjg1MWFhMCBSMDk6IDAwMDAwMDAwMjAwMDAwMDAKUjEwOiAwMDAwMDAwMDAwMDAw
MDAwIFIxMTogMDAwMDAwMDAwMDAwMDIwNiBSMTI6IDAwMDAwMDAwMjAwMDAwMDAKUjEzOiAwMDAw
MDAwMDIwMDAwMTAwIFIxNDogMDAwMDdmYjc3Zjg1MWE2MCBSMTU6IDAwMDAwMDAwMjAwMDAwNDAK
IDwvVEFTSz4KTW9kdWxlcyBsaW5rZWQgaW46Ci0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAw
MDAgXS0tLQpSSVA6IDAwMTA6ZXJvZnNfaWdldCsweDEzZGUvMHgyODkwCkNvZGU6IDAwIDBmIDg1
IDE2IDEzIDAwIDAwIDQ5IDhiIDdjIDI0IDI4IDQ5IDg5IGQ4IDQ0IDg5IGU5IDQ4IGM3IGMyIGEw
IGVlIGU0IDg4IDQ4IGM3IGM2IDQwIGYxIGU0IDg4IGU4IDQ3IGIxIGZmIGZmIGU4IGUyIDlmIDM1
IGZlIDwwZj4gMGIgNjYgNDEgODEgZmUgMDAgMTAgMGYgODQgMTUgZmYgZmYgZmYgZTkgNWYgZmYg
ZmYgZmYgZTggY2EgOWYKUlNQOiAwMDE4OmZmZmY4ODgwNTdkZTdhMDAgRUZMQUdTOiAwMDAxMDIx
NgpSQVg6IDAwMDAwMDAwMDAwMDE3MGEgUkJYOiAwMDAwMDAwMDAwMDAwMDA5IFJDWDogZmZmZmM5
MDAwNjkyMTAwMApSRFg6IDAwMDAwMDAwMDAwNDAwMDAgUlNJOiBmZmZmZmZmZjgzNTNjYjdlIFJE
STogZmZmZmZmZmY4MTZjYTcxMQpSQlA6IGZmZmY4ODgwNTdkZTdiNDggUjA4OiAwMDAwMDAwMDAw
MDAwMDA1IFIwOTogMDAwMDAwMDAwMDAwMDAwMApSMTA6IDAwMDAwMDAwODAwMDAwMDAgUjExOiAw
MDAwMDAwMDAwN2I4ZjU4IFIxMjogZmZmZjg4ODA0NWRlZjU5MApSMTM6IDAwMDAwMDAwMDAwMDAw
MDAgUjE0OiAwMDAwMDAwMDAwMDAwMDAwIFIxNTogMDAwMDAwMDAwMDAwMDAwMApGUzogIDAwMDA3
ZmI3N2Y4NTI3MDAoMDAwMCkgR1M6ZmZmZjg4ODExYTM4MDAwMCgwMDAwKSBrbmxHUzowMDAwMDAw
MDAwMDAwMDAwCkNTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAw
MzMKQ1IyOiAwMDAwN2ZiNzdlNjYxYzQwIENSMzogMDAwMDAwMDA1NzY5NTAwMCBDUjQ6IDAwMDAw
MDAwMDAzNTBlZTAK
