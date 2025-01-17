Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E738A14C76
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 10:52:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YZFPn6wkdz3cmW
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 20:51:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=114.132.58.6
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737107516;
	cv=none; b=cuR1ePSWXn/HCiti3DXIxx5XPowi4wCGcx+iaE6pikhiq/DfQmkPXpPLlstURw/hJ228Po8d4vPgoHVOvvxVTIEQSWuj3j7kf0XUBYQnFw5sslzXjeFcS4gd5aLujHEJ8so57mE1Lh43cDEYMNa8qHrZefyFdc3ZCSBOdr1PCdWeomLOL62u5xS6IS3Mc0zqtwBjYMJfa6DkAl1G9aDjbo+MN5TtM3/BXsbOequs05fMhb4RiYEkhndWEfKhSyPwnIoG+G9ACkZrE3sEOBjCg2VwhA2isDoUFjZSFFrUOD0b26rDDWMJJ6UsbbhxwpFV85KsOAAvbRf9BcLh8icoBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737107516; c=relaxed/relaxed;
	bh=eQIpWuURfNPyg7nD6EGUHbcp/GSZ0Yd9Z4EILXHxmzk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eVk4Afzolpx5pCmVpY7PX+0JtDjMx63raKcOYVxjIvy6osU7x7B9N8UveKWcVh7GbJop4Zls7GNoSd7phThL/X4hkcBjir3uCjnTNjV4XcvQoETej90De+nzLHxLRFGOAq1Z0alVS8eRHhHqXxHwbtUAdXVKEYii8oc+q1Ww5PJPxoFYp1kc6F3/JBYYXuTeRIDG1nRLwzIg92hfj8b2ep0ynKOjVZJ7NIBwz0TJDtEKH9O9hnYZTIPVEQiREnGEEpD7H0siVn3kwrEpJ9hEfmh/Ya22aaIf4Ab6BLWZvIXoDF4RBxxoUeDrh7u34X2RzZM7E3STweZUYBV/EIQaIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=WCkfRL4m; dkim-atps=neutral; spf=pass (client-ip=114.132.58.6; helo=bg1.exmail.qq.com; envelope-from=chenlinxuan@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=WCkfRL4m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=114.132.58.6; helo=bg1.exmail.qq.com; envelope-from=chenlinxuan@uniontech.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 3459 seconds by postgrey-1.37 at boromir; Fri, 17 Jan 2025 20:51:54 AEDT
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YZFPk1Y2Qz2yD5
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Jan 2025 20:51:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1737107457;
	bh=eQIpWuURfNPyg7nD6EGUHbcp/GSZ0Yd9Z4EILXHxmzk=;
	h=Message-ID:Subject:From:To:Date:MIME-Version;
	b=WCkfRL4mBHoYuDRbsm2Zt15x+l/z23Z7hW460xvxwNeJPMyE3zdd2dR4OC0vkEHNL
	 /+UItXxTd2w8zMRhdr8QZf7cIG+vYHCWfcyNSx/8Vr2HmybOu9mxNEZy/+jzijf1VQ
	 eXBQLUcfeRPvde64K4LMHZl1zZdrl1U6+Pnqw+Vc=
X-QQ-mid: bizesmtp82t1737107449tu5j726h
X-QQ-Originating-IP: Yh/qzV+OlTAMWfsFHsC73OfkRC4EcFEn8O0lTRMBcIg=
Received: from [10.20.53.121] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 17 Jan 2025 17:50:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16301761484669451130
Message-ID: <640C401CAB291F86+ffb78b4f37e75faf2b4730e625b8d72d15be782a.camel@uniontech.com>
Subject: Re: [PATCH] erofs: add error log in erofs_fc_parse_param
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Gao Xiang <xiang@kernel.org>, 
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, Jeffle Xu
 <jefflexu@linux.alibaba.com>,  Sandeep Dhavale <dhavale@google.com>
Date: Fri, 17 Jan 2025 17:50:47 +0800
In-Reply-To: <649afa9b-5724-4b52-8b9b-9a82a3c1468b@linux.alibaba.com>
References: 	<F2F43EB045D266E8+20250117085244.326177-1-chenlinxuan@uniontech.com>
	 <649afa9b-5724-4b52-8b9b-9a82a3c1468b@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: MMsYUpenvTldIegjkrUbMUB5/poNyNNtd7Llvr+0yfCcf/SvPlbJ0SI+
	1OkKgwYeWx4PUkXEm4NIIJuzGGD9Hz7EBa9og/wzxM8Uc0PRfJUGflgDbaj1xcQwA4p/M/2
	cxaq1v9lzv+Xhox48tSFmq/wLFz8Ygotp8Ly1jaLO/x9w3/7iGPKJZptXGXVkUBJIEz6Ln5
	/2hGIkQ9Bfs1jOyibRkPdpvsNRNEzUnMN5QDTqotcKdX+aIW+P8dyqdA2LzIS906oMBRN/y
	Z/f1a2fmM9X5wrA19QJove/+vbamab+P7bHEpWqGWGWjragP/lrjpi7V5VBWJlqa2//xkGy
	XF/xa6NEJbVzrXmaQz+ieK1nMZl6wzTll5KB2Gdo1AG5TtNh+ss+/+EYZwDVoZtoGz9UwZB
	GYoYcCk35g39VXr/VR6nKbRGt26yMKwm4hyswmcwD+BmxY5PuLJhiHJ1IfLaCWBrlb8hAnw
	EHoW9erIkJBxU79s/7z3TLDJ4vCExddV0jZfUNErV/i/WtDe+Mz4bkGZL8ULF1xQT5FNS5B
	dBHD3tGI5I98YES34Grr9/rhoKiSwB5bVIBEAsFrnWpUIE7RH7VZ+dwAWcQivRA3hJpNOFE
	zDOsRn5tCUnQibn1J75/uTpc64VHSG3jwE0llXPN74yb2Ui229bfU8GrKfgwjfr7IajHGbJ
	P/nnSBYrECaL8k/Pmf+skebNc8lWqbcGLhZ5t9TdDxJzGd4iAS60w6/7sS2tFebN8R6jWjV
	rHUQLRg6RsTyV56hOFhe/VpG1IOm1Z8qlACCTi5iGd5kK2bDvYlW7tclV+2RBDqaezxG7B3
	TKZIpfhlB0VUw28rxeHohgb4CS9tCySEaieig85e/fW3Luf2hYhcjIHdE1pglgescxYyit1
	VdajoKCpTJjE8ySddPVvvwcEhF1GCUdi1z6xKNHJBHsTCoQeOjBvBg95WKCDtIUv3IJTv51
	j4QyMA7QJ+Q66oXDw63sArkzhFcfRxpLoMy+jYmRwnuhhccZkI1wp+pPlFYAG9jojX/F//O
	ThjrUOfZxiLR8UvzsrpecMQyYbbxoV+roy+lVOkOOpxivmffwW
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
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

On Fri, 2025-01-17 at 17:28 +0800, Gao Xiang wrote:
> Hi Linxuan,
>=20
> On 2025/1/17 16:52, Chen Linxuan wrote:
> > While reading erofs code, I notice that `erofs_fc_parse_param` will
> > return -ENOPARAM, which means that erofs do not support this option,
> > without report anything when `fs_parse` return an unknown `opt`.
> >=20
> > But if an option is unknown to erofs, I mean that option not in
> > `erofs_fs_parameters` at all, `fs_parse` will return -ENOPARAM,
> > which means that `erofs_fs_parameters` should has returned earlier.
> >=20
> > Entering `default` means `fs_parse` return something we unexpected.
> > I am not sure about it but I think we should return -EINVAL here,
> > just like `xfs_fs_parse_param`.
> >=20
> > Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
>=20
> I think the default branch is actually deadcode here, see
> erofs_fc_parse_param() -> fs_parse() -> fs_lookup_key() -> -ENOPARAM
>=20
> then vfs_parse_fs_param() will show "Unknown parameter".
>=20
> Maybe we could just kill `default:` branch...

ext4 do not have a `default:` branch, but xfs return -EINVAL.

I think `default:` branch can report error when `fs_parse` or
`erofs_fs_parameters` goes wrong.

But I am OK to kill `default:` branch.

>=20
> Thanks,
> Gao Xiang
>=20
>=20
> > ---
> >   fs/erofs/super.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> > index 1fc5623c3a4d..67fc4c1deb98 100644
> > --- a/fs/erofs/super.c
> > +++ b/fs/erofs/super.c
> > @@ -509,7 +509,8 @@ static int erofs_fc_parse_param(struct fs_context *=
fc,
> >   #endif
> >   		break;
> >   	default:
> > -		return -ENOPARAM;
> > +		errorfc(fc, "%s option not supported", param->key);
> > +		return -EINVAL;
> >   	}
> >   	return 0;
> >   }
>=20
>=20
>=20

