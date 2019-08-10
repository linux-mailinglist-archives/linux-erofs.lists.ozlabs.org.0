Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FB68877C
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Aug 2019 03:14:41 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4653zy3wSRzDrMC
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Aug 2019 11:14:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1565399678;
	bh=c6KB1pSIAPOS1HEq+thH8PoloVPqQy/yQ8z7e/1UAtE=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=jfzDN/qUx/wsx+jutPVylq0ZYXxdGMKXQNnGvbigDYib48JgwAhSbDni0y1QR5AIP
	 vFmxYSbMqeT6os4IArUmxXYT/FAN1FsCmq+9xMaaS1Hb1qEl6wmVVdQ7CpO5TcbLQQ
	 6jct0IDIxkXrDQ1sntaxDtH1PkndHo9sT3duWy8u53IkYL4rTeSTYStL1Wg0ktoIw/
	 pCUepzFHhQrrlAs4pfLr0Zd0tLIUMNr4VOS8NkCySVWOn5taJ00Msbsk8jbpeF0Arw
	 lO3EwMnGvWKv+LmSCEU2zTX88pyqEPkV3ud2VRFWxxciYdrn+WaYZWoLesEJJW9eAC
	 AOKYvcs69+4sw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.177.146; helo=sonic314-20.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="jFfzn3z/"; 
 dkim-atps=neutral
Received: from sonic314-20.consmr.mail.ir2.yahoo.com
 (sonic314-20.consmr.mail.ir2.yahoo.com [77.238.177.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4653zq28RHzDrLj
 for <linux-erofs@lists.ozlabs.org>; Sat, 10 Aug 2019 11:14:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1565399642; bh=LeyHkweEnBF9Orjuuf8aGASqZEslnXU05LY3MNgjJm8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=jFfzn3z/4kbEMWyYCCTUfQfSzZohh95Yb59ESsu569NxsZvciGmxpbyXJgGLP7pItdsNxruY0YjMdyOxtf70g2PgRLyWtvGWd2Jv0rLWCthp5HMXvuRHnV8i2ywnyLJNFj4sP6sN96elOfqfD1hBdUqqG5FirbSPb8niy6w12Mevr49qZU7UNRmKfTPgY91ZvSCyL5argTV3NcZj5J4nOOWSaiYcyx4CfjbJFJDrKFmYumx0A8lVb9zGracuSFe7cmgpybCAE28ep50FKIaOpjl1jK5cSZ7Hby2tXe33ot/tgZalbqOjicHmd4EgYAc4+Jo5nHeMDDth92m0tX/v4A==
X-YMail-OSG: L14tSp8VM1ngxnfURFcRWHBIzFB3cCMUzSUMvrLjQLgAHdOjf9UkGOgagl5qHlo
 dSWo1pH4HDyalulj8fw_rIbkN6TSChC11_.iV2X6E_1ir2uvZdPhHu.zqdTlbMUmC41vgAnyvI3T
 J0ozOn.CIQqMvd2mGKcCTS1tdDgFB2r5iQek79vw.VoOhGU97LcHjv2OgSeOSxCtS8EN33XdFKnN
 Ukgrne.yvU5jRHH8HQT_gr3_07tIH1HclFZZ9vk4bVk1YmAfBvhsxAXzTmMHeW7ZO4N3k3DHE20g
 xvvWZUTTKCOP_8icfujT8MR326AwoBEOL.wM5vKY4OALJPb33BvcQcD6E41qfSFyLJQt7fmaFe9n
 DPP2Cl7CRQF83WjpebEmw0jHf0d4z.5.QcEcxcW_xPK4BPPfqlHSZRSvUYCl23NISesmuw8NDnz2
 Fw9DLHI0j8j6HdMNa53FCjneVOt1LmO3ZFnSi8hel1roDfMezPqMQkY5q0cnCG7WsFWnVpShS0yI
 ktdXqzHLJ1VRcWJLLS5sQkSN7zgIvlJNudGh56Lkw8Ro5PYRaOFE8Il.xdoCrrO8ANcm3QtNUroT
 NxhoZ3FnEnEs3eCoPhl_mvSCT0Ebs_L5wHXfd6n59aVTRMJoLT27B0FuC6Mt0PEmd1MwI4EY_Do8
 PAM8g4FJ9rxnu.6EFx8ivUpDvpIeR5lbRklZ4NKJiQyRQjoT7GOEjFwq4X33LzhMKAGG3HjJvKBn
 qw3KZxovQDLjDEgxYUmi8IxKq7imhdnQqeqmIeiG2fHtQ2Kfc0iogXLpHrljT5sRK4wPQ9fFaHzF
 W1aa_4lYqMZQ_3bupT1TrUrnVOZXeOUxHHriSux72DC1fDKCmZZoLpLnQATcr3DNtdk1anxi9FLr
 TUl5vTvUn9M1cJcKek_5_qVca09wwSW4Fy1YI9C8hkBST1Li8oaGSf.OV3MdqEkav4ds1ITGdYCk
 eaKTsUfp_DCeyY6ve7MOLPEeBkJK72sxjPtOV7qlygKFv3z3aNfg7nmDbJVOjc2EN2nX2HJithoP
 NGGYIfqaycXlFEM4Mil4edgEAmYhBFDERqtkcTw3ct7WirralHseOJixjViOgEwFT_RrNtiY4vlI
 hKMBcsaKF.D8M4JNW92JrWKAlHlgk9aNF57EHSupwkg01P56IhAAPiLCbo_krOGCv9YAREP9_fBP
 INczjgttrN3nHh6cvqXp7g6Nxq_kaTuveJXoFdaGoHm_iO5a9NBNpmyDmQnefAEyZySEAqWB_NDw
 rvdvF8UdWpNCXPMfElOkrBmw8dCdliQa6L3kONHGL
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic314.consmr.mail.ir2.yahoo.com with HTTP; Sat, 10 Aug 2019 01:14:02 +0000
Received: by smtp403.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID a4f95cbb34fefc998ce13e4b24f0b0a6; 
 Sat, 10 Aug 2019 01:13:59 +0000 (UTC)
Date: Sat, 10 Aug 2019 09:13:50 +0800
To: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 10/13] iomap: use a function pointer for dio submits
Message-ID: <20190810011348.GA27374@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190802220048.16142-1-rgoldwyn@suse.de>
 <20190802220048.16142-11-rgoldwyn@suse.de>
 <20190804234321.GC7689@dread.disaster.area>
 <1565021323.13240.14.camel@suse.com>
 <20190805215458.GH7689@dread.disaster.area>
 <20190808042640.GA28630@138>
 <20190808054936.GA5319@sol.localdomain>
 <20190809204517.GR5482@bombadil.infradead.org>
 <20190809234554.GA25734@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190810003135.GF100971@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810003135.GF100971@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: "ruansy.fnst@cn.fujitsu.com" <ruansy.fnst@cn.fujitsu.com>,
 "darrick.wong@oracle.com" <darrick.wong@oracle.com>, miaoxie@huawei.com,
 Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 linux-erofs@lists.ozlabs.org, "hch@lst.de" <hch@lst.de>,
 Goldwyn Rodrigues <RGoldwyn@suse.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Aug 09, 2019 at 05:31:36PM -0700, Eric Biggers wrote:
> On Sat, Aug 10, 2019 at 07:45:59AM +0800, Gao Xiang wrote:
> > Hi Willy,
> > 
> > On Fri, Aug 09, 2019 at 01:45:17PM -0700, Matthew Wilcox wrote:
> > > On Wed, Aug 07, 2019 at 10:49:36PM -0700, Eric Biggers wrote:
> > > > On Thu, Aug 08, 2019 at 12:26:42PM +0800, Gao Xiang wrote:
> > > > >     1. decrypt->verity->decompress
> > > > > 
> > > > >     2. verity->decompress->decrypt
> > > > > 
> > > > >     3. decompress->decrypt->verity
> > > > > 
> > > > >    1. and 2. could cause less computation since it processes
> > > > >    compressed data, and the security is good enough since
> > > > >    the behavior of decompression algorithm is deterministic.
> > > > >    3 could cause more computation.
> > > > > 
> > > > > All I want to say is the post process is so complicated since we have
> > > > > many selection if encryption, decompression, verification are all involved.
> > > > > 
> > > > > Maybe introduce a core subset to IOMAP is better for long-term
> > > > > maintainment and better performance. And we should consider it
> > > > > more carefully.
> > > > > 
> > > > 
> > > > FWIW, the only order that actually makes sense is decrypt->decompress->verity.
> > > 
> > > That used to be true, but a paper in 2004 suggested it's not true.
> > > Further work in this space in 2009 based on block ciphers:
> > > https://arxiv.org/pdf/1009.1759
> > > 
> > > It looks like it'd be computationally expensive to do, but feasible.
> > 
> > Yes, maybe someone cares where encrypt is at due to their system design.
> > 
> > and I thought over these days, I have to repeat my thought of verity
> > again :( the meaningful order ought to be "decrypt->verity->decompress"
> > rather than "decrypt->decompress->verity" if compression is involved.
> > 
> > since most (de)compress algorithms are complex enough (allocate memory and
> > do a lot of unsafe stuffes such as wildcopy) and even maybe unsafe by its
> > design, we cannot do verity in the end for security consideration thus
> > the whole system can be vulnerable by this order from malformed on-disk
> > data. In other words, we need to verify on compressed data.
> > 
> > Fsverity is fine for me since most decrypt algorithms is stable and reliable
> > and no compression by its design, but if some decrypt software algorithms is
> > complicated enough, I'd suggest "verity->decrypt" as well to some extent.
> > 
> > Considering transformation "A->B->C->D->....->verity", if any of "A->B->C
> > ->D->..." is attacked by the malformed on-disk data... It would crash or
> > even root the whole operating system.
> > 
> > All in all, we have to verify data earlier in order to get trusted data
> > for later complex transformation chains.
> > 
> > The performance benefit I described in my previous email, it seems no need
> > to say again... please take them into consideration and I think it's no
> > easy to get a unique generic post-read order for all real systems.
> > 
> 
> While it would be nice to protect against filesystem bugs, it's not the point of
> fs-verity.  fs-verity is about authenticating the contents the *user* sees, so
> that e.g. a file can be distributed to many computers and it can be
> authenticated regardless of exactly what other filesystem features were used
> when it was stored on disk.  Different computers may use:
> 
> - Different filesystems
> - Different compression algorithms (or no compression)
> - Different compression strengths, even with same algorithm
> - Different divisions of the file into compression units
> - Different encryption algorithms (or no encryption)
> - Different encryption keys, even with same algorithm
> - Different encryption nonces, even with same key
> 
> All those change the on-disk data; only the user-visible data stays the same.

Yes, I agree with fs-verity use case, and I can get some limitation
as well. (I am not arguing fs-verity in this topic at all...)

> 
> Bugs in filesystems may also be exploited regardless of fs-verity, as the
> attacker (able to manipulate on-disk image) can create a malicious file without
> fs-verity enabled, somewhere else on the filesystem.
> 
> If you actually want to authenticate the full filesystem image, you need to use
> dm-verity, which is designed for that.

Yes, but for generic consideration, there is a limitation for dm-verity
since it needs filesystems should be read-only;

and that raises another consideration -- verity should be in block/fs,
and I think what fscrypt answers is also appropriate to verity in fs
(since we have dm-crypt as well), that is that we could consider
multiple key R/W verification as well and blah-blah-blah-blah-blah...

I think all is fine at the moment, in this topic, again, I just try to
say a generic post-read approach is hard and complicated, not for some
specific feature.

Thanks,
Gao Xiang

> 
> - Eric
