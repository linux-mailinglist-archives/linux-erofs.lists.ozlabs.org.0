Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 247DDA14CB2
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 11:02:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YZFdk5txMz3cmW
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 21:02:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=54.92.39.34
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737108137;
	cv=none; b=RBiAdBJvdf6ZK9zQrrQ0JdnSHo9TemFRPdtsjGrTsTO5u/8V2aVoSdh49Tgufpn+ipPLY356ZJVamufUHuxKkb5J6j3dv1Xg+mj+LqTXPNDWIRu4A49p/602Ff+SUBUE58vz1FqxopQ7mUkl9bDOLLVt2HPqL79fq9pW2SD7NTH6MAEZiQFYt84vQP/9wXhxPDUBxxOqXZ0r348lJQUxYAIREmH7rmWASuGs1NgIRIG1m9yDkLjlHsznwiSpSM9BMiRVjcMEeyTtBKsbb0gF8mbw9k0QlOjJdAnkaPMUA1+S+HvIxokQZjavdBXUqNd+Foyj+9S7vjTYn1hEXZaVtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737108137; c=relaxed/relaxed;
	bh=glprG9EU/c3C20X8BgxQluKLP8QndZuBpiazYVNfrzg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h1S2a9Cc6q1jDdFblauMMek4CckuQQSdMKn3mcQYfQP56WodvQ+b5pKZ3KIzsa8QzkXmGLfHPwk3/7CABHgF75jcyDQ88EG7eu4/AsjZOxXirO5MkG10d92R2+iSFLKH93zZHIjw4oyfCQSkWr+02dp1X0CsxnyLSHZNQ12uO3KaEe4T3569Wh/ezBVHyOJP9oN05WYYdJgfD1wVEpIos1qPZ2vb3Ypu2YyQd73brOUs6TqiWW0Rz+zbSbK6TvripvKblPi/B0SKfr7C6KeOLR3pQwVG0C9ZUCmDDAnrXR6vgRqc5tD5jDq0KTzcGMKj15eZjPqxim3q1EgeXP0ZXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=ZBRXhnyx; dkim-atps=neutral; spf=pass (client-ip=54.92.39.34; helo=smtpbgjp3.qq.com; envelope-from=chenlinxuan@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=ZBRXhnyx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=54.92.39.34; helo=smtpbgjp3.qq.com; envelope-from=chenlinxuan@uniontech.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 4086 seconds by postgrey-1.37 at boromir; Fri, 17 Jan 2025 21:02:15 AEDT
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YZFdg56nsz2ygZ
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Jan 2025 21:02:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1737108087;
	bh=glprG9EU/c3C20X8BgxQluKLP8QndZuBpiazYVNfrzg=;
	h=Message-ID:Subject:From:To:Date:MIME-Version;
	b=ZBRXhnyx3ex8AALBMXbWLzLreqT1Fbb5ya32sABtXd7LJyNdhkphZWoPpw96J79YI
	 3cZdB+EYT2G8z+5pAXP0QpkclaMOAPiXdmNK51WhdEEhiUmC1rmBOvsjXxVkYwRWmk
	 ysMjSbVdaUyn1NWNTJa2dPq0twFH5bnHA9AiDbko=
X-QQ-mid: bizesmtpsz6t1737108079tfx1978
X-QQ-Originating-IP: VFnRGADdjR/Tl+pVgzKLw2jXQWF0sDRugEzWK1ybP6c=
Received: from [10.20.53.121] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 17 Jan 2025 18:01:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5411443667271281956
Message-ID: <63C443BEC911CD0D+401525867484e4d20ad2e6f6809491a7efdf56f6.camel@uniontech.com>
Subject: Re: [PATCH] erofs: add error log in erofs_fc_parse_param
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Gao Xiang <xiang@kernel.org>, 
 Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, Jeffle Xu
 <jefflexu@linux.alibaba.com>,  Sandeep Dhavale <dhavale@google.com>
Date: Fri, 17 Jan 2025 18:01:17 +0800
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
X-QQ-XMAILINFO: NAPEGMJiOsQ6nTcyN/S3HRqzwl2lWlXCPhQUu44qcaMklz8AvEZJjRcY
	bsyEX40W2aV1tlinZLQspRojpQ8fHcFHIzZdNNMlTe/rcVn/91j5OxUUsRh9uyUeSMmfBJ+
	JZPs5dSXRB8uqHb9YvYd1wc/Brh67ROiOGkMBFKbW6y16VEYQ658XpsrHqbk6WrQOBXv8HX
	2IdXv8p3GLb1MpansXqa70iqyLa1ionKHqWXP7GAJjK5uFpVgZMDQ/V3pM4MGm7estgxwGS
	/nXfxws2W5RP5DmyHfsyHFsamvqJ/fwlCoiB+R7f1ur4PT8A8cY8fbH1McHNjrVCD4puaeQ
	O42Rz6Z+NZQDDpQAONbU/faeyjojHSOlkv0rqLzMZJ9tfJgeX6hJY7PEZjK+/Pk1rZliKSu
	YWXohrOIKRf/LKo9ClAQmypgxQVcNHk9m/dhzdmq2y9/YC/rI1D4lzw7msSDrLdl3Lwmbbh
	/eIcAVH7F5p/X/kEGqpG184AVbc3LnKhSwH5AtQVGCKsALRQyL1u8tldZeO7G5CWqoJVWaC
	wJ0ISu8/nT1waOLzvik6m11NzBMVx3k78cZ1yCTh0wrcQ+Dz0SGbpLBQgnRfdqiPk5kBKqO
	FTgdNdmwWf4rTq4WD1ZeooBnc4MZOeK9mUR7D8rAjU7qZhG2amawBG4AMT+tYT5j8JN6Jdg
	yOQOok6nIYl2FI6qMli6WKhkvzRT3c2M4D8m8GpwQAPoUgaUGnE0LgAWbS74GrZ3++xEOcR
	fYtHts6aEUboV/4OHj1NLiY1b93HQx2QIltVXhj7qLb0zzsf64CAGbXrrRqcu6d9PogYUri
	59WqPCJqZlIeOoNcdia9/yyr6SLlHz5u7ozlJnJC6E94I1aCSCSQBJgXZsY+F24hQT7eyxA
	328jeIF2DQ9zJ1GU7LMjM8u0I3uhZhC+U4nFP6Nk9o8UH6sAtdSlzRo+iizfOubQTTJdFqs
	wpfeqextBJ0R6O+Tds5ycm5iQtlPUaO0ohypds2OoryFU1cVm6aaE0mBhsvoMQq3VPZ98mm
	VdfriEHz20qEjREa7ZpII1xEIVGQ9GDO+WX0gBUgEL999l8xfy3jS/Cvl9sfch1wEXtnDE7
	4li8R78jSNp
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.0
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

I will push a new patch just remove the `default:` branch later.

>=20
> Thanks,
> Gao Xiang
>=20
>=20

