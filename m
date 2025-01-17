Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215F2A14CAD
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 11:01:14 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YZFcR2XSCz3cmW
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 21:01:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=114.132.67.179
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737108069;
	cv=none; b=DwHkqkWFBVaKa+rjLPweuQ2wYfJ39v80AA5XnXNwtR/IaZ8K8VmVji3XzbMiSagWRf6tGv4MwpKNKYIvRzMSVR/HjMpbpdXo3gwKpxoKisZcVCcUkVfKzTao/EIgf+zLDYF0LSLiWOQQbZRSv4RdMYB8pgG7bLW0MU9QLuP84/kAEI1DgDDLuR73NqowMCdDifw4YwY5Gg6c/fq9eamnGCD5+AAVOYxECSKR+J1KaZQ9/KLSize/voGMCV2Oz5j/4Nnfkn4bGVZUaM7QhLnWvg7zyza2rt+7YBHSDY6CWBbz4basmL1YChLIMRKSLWdB4o3gtFfcvnGszCNuES6haA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737108069; c=relaxed/relaxed;
	bh=iroahr4L/hXSymMs+KBf1zuyCZ3KWVQntlOvBOyyssg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KAgVIb7Pcj0q3lcKq1b7NuJd567GNCM/tHwdVb+SNZ6hbt1Y2rNuDUmPZu2yx6QOl4QD1iWE6JuThnBC9nU32J0xfI68AP15uk1w2lO3gyiTT8vSdEx7JDf0rv5i6AZtvXiOAhWdKyTb9QqLA16c7bYMwXZmEVGLw3FpfagcXVPa1BcVqBrivRmPTfy+8r/vWxnm+gaU33hERsXaR7ZsE8GSCze4jjPRZG9HlJGjwYJHkBPr6osxRv6MZgv/NxOpg5rBmiTsNzZ67ZRDYOpAuWL1BnGkBUT0RGBGjB0Equbvb6/yPXvZcEeopkTxvGlEI+120gm7V/ywNWWEBRAZkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=mMSaDguC; dkim-atps=neutral; spf=pass (client-ip=114.132.67.179; helo=bg1.exmail.qq.com; envelope-from=chenlinxuan@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=mMSaDguC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=114.132.67.179; helo=bg1.exmail.qq.com; envelope-from=chenlinxuan@uniontech.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 95868 seconds by postgrey-1.37 at boromir; Fri, 17 Jan 2025 21:01:07 AEDT
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YZFcN023sz2yRd
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Jan 2025 21:01:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1737108017;
	bh=iroahr4L/hXSymMs+KBf1zuyCZ3KWVQntlOvBOyyssg=;
	h=Message-ID:Subject:From:To:Date:MIME-Version;
	b=mMSaDguCicvMFv6Yq1XgZdwYhNSPFytKP8bUb6gtB8pdnj3hO5RZbZaYHnypd8M+E
	 01wWgRclMx2Qu6/zlUQ4+nLVqgkV5dJBLgY/mbxEbzTzvlD2lsHGSibWrcJAlrCiRx
	 rwz4I2BqzKeGCfdeZZwkRGsnVqJEgSbDJzfu+tR0=
X-QQ-mid: bizesmtpsz13t1737108008tq1m1p
X-QQ-Originating-IP: XftBdMHapIvM6TIJB5Um9hxzRHTjVtgMwVC/qP1x2yo=
Received: from [10.20.53.121] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 17 Jan 2025 18:00:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12575968525061132533
Message-ID: <F2BFB040EAD9A1F5+3902f0717d54a9990ffe8f042997c8586044d229.camel@uniontech.com>
Subject: Re: [PATCH] erofs: add error log in erofs_fc_parse_param
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Gao Xiang <xiang@kernel.org>, 
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, Jeffle Xu
 <jefflexu@linux.alibaba.com>,  Sandeep Dhavale <dhavale@google.com>
Date: Fri, 17 Jan 2025 18:00:06 +0800
In-Reply-To: <58cadb57-22ce-4818-af2b-9ae452c38f27@linux.alibaba.com>
References: 	<F2F43EB045D266E8+20250117085244.326177-1-chenlinxuan@uniontech.com>
	 <649afa9b-5724-4b52-8b9b-9a82a3c1468b@linux.alibaba.com>
	 <640C401CAB291F86+ffb78b4f37e75faf2b4730e625b8d72d15be782a.camel@uniontech.com>
	 <58cadb57-22ce-4818-af2b-9ae452c38f27@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: M66kUMUCCKBmVLmqvRhpm8+Zr8Df0tOsniDz3Gi303+u6Ln1XpzbkRBo
	8pmie3WyIVkmpU6y+GIM93vmwma7EfA8x5kzIRZij9rHZVnffqY2VkvsriJJQ3gh4DXtcUw
	AuuJNrC5BIMP8wFtT4+jWTAyg1mz0q+7TZmLG5pzYhJdMYOuE8evyNTePOC6u/SsudffZn6
	NARhrQB2xkxGM0beKsKu/sk5EoMOdJimLBd7TmUD94v10Z1MEDRnQGKAUC+LGcBbiBcNiE+
	L63zvBlFP77aEFie0a0SbXlv3k2kM5vQ4oI1hVkxPksRIHJjfUFA86P2oQ2+Tl+rOQrmDdt
	KKGSYPeh2HGNe/+kzj7VOhH1wv6zawoa5NgkQRLp1iM2KO09JKhb7XPvBnK6uIK0HjH2kW3
	vtghedlo8mCJanVF7nt3YAHbu5fTfDgR4eoATThUn89SVm+Kj/3Wnd6eY8w5v4/+WVlnY5c
	RMSNDuHyovbA6puV0ZgiFQnRYpRTbfgRejb9saFnGGsXr1wd+adel40bUjGTVFbHn1nC4bl
	EMzuEDV0N/a1OEKyZjMdHtbHSbr5POjsOrWNapRFn2bve5UcepA6nsX8zu3CZMkZHo1cM06
	ctEYkxFVNZiE+lR8+2x+jabE5Odqdueze9B98aBVH9FmVgU/D6SMznP2mVVpTO/oB3TNQeD
	C4iXUxQHHdL/0cJaSRwEMeQoUie3zqAwYysWgzMMDQ0wvZ31t2VCq7i3IHHK7/u0CS1V0LS
	6FDtnKm0LdDAI66G3Jtkoy/gSmnIRlfkbR2IXh7ri1uK+nhNzmzVSbcYrk0CsILDoU9fnWY
	0ZUjIGB54mDoanO6FWd7Wq9rs0lu/TPXDVsjpXESbkFfcbq+vaKs+yxwlx+IQ0K3K5RWake
	SR3GZVeDbALAwkXkagpH08gIs1QiKTETitH9ROeqNjWQ1GAwhNAPTC+MewR0UgMmNnpYC+d
	cljZZp7XYGZE8S7gmAC8d3nLPDTEnRPI+lvaeKKQkolSuxC8OyGJPO8bjGIN42Eng4rNdQV
	KBFabxqMc4kH25I4swqI+7rCsTkPk0Rhx5lP5YYQ==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, 2025-01-17 at 17:54 +0800, Gao Xiang wrote:
>=20
> On 2025/1/17 17:50, Chen Linxuan wrote:
> > On Fri, 2025-01-17 at 17:28 +0800, Gao Xiang wrote:
> > > Hi Linxuan,
> > >=20
> > > On 2025/1/17 16:52, Chen Linxuan wrote:
> > > > While reading erofs code, I notice that `erofs_fc_parse_param` will
> > > > return -ENOPARAM, which means that erofs do not support this option=
,
> > > > without report anything when `fs_parse` return an unknown `opt`.
> > > >=20
> > > > But if an option is unknown to erofs, I mean that option not in
> > > > `erofs_fs_parameters` at all, `fs_parse` will return -ENOPARAM,
> > > > which means that `erofs_fs_parameters` should has returned earlier.
> > > >=20
> > > > Entering `default` means `fs_parse` return something we unexpected.
> > > > I am not sure about it but I think we should return -EINVAL here,
> > > > just like `xfs_fs_parse_param`.
> > > >=20
> > > > Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
> > >=20
> > > I think the default branch is actually deadcode here, see
> > > erofs_fc_parse_param() -> fs_parse() -> fs_lookup_key() -> -ENOPARAM
> > >=20
> > > then vfs_parse_fs_param() will show "Unknown parameter".
> > >=20
> > > Maybe we could just kill `default:` branch...
> >=20
> > ext4 do not have a `default:` branch, but xfs return -EINVAL.
> >=20
> > I think `default:` branch can report error when `fs_parse` or
> > `erofs_fs_parameters` goes wrong.
>=20
> How can it go wrong?

What if we forget to update the switch branch for a new option?

>=20
> Thanks,
> Gao Xiang
>=20
>=20

