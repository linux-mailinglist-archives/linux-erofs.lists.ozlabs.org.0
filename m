Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12355917DC
	for <lists+linux-erofs@lfdr.de>; Sun, 18 Aug 2019 18:34:03 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46BN132rZMzDrC7
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Aug 2019 02:33:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1566146039;
	bh=C5OBjTXmm3iJ5QdCwpgvjycvQ35EmNJ+o9Ap+1VhsMo=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Q0eUwdLwR7/8VxHWtED/hSx4gYZ7jAlgWHFZSvBltrGg1YtCd7tUf/NHX2Spy/Gws
	 l7tQuC1lUhNxgHqbAGk1a3809/OgtWopGFSlDp1HAwiRlTG1pD1tAinHr9sNv3Zy+9
	 4HyI4qJvNter8tfengUcvbyBjvkalfusEetfZkwF8mLMhkBzcfeG+DpujotScgGqjD
	 Zo3NlswyclTZocDDHYeZsqCDY9ah2nIBIj4+DHURdl6k1Xf9Qgcd3f7sXcUyrspKDT
	 c/rSsJQ01vaNB16hmGGoA1zP2NzrnguOJ0e1+OB6uEUIFsSVLmCAwzn1FU51wsBMQj
	 wQHsnVN/Kqdjg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.64.205; helo=sonic303-24.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="NxqzZzhe"; 
 dkim-atps=neutral
Received: from sonic303-24.consmr.mail.gq1.yahoo.com
 (sonic303-24.consmr.mail.gq1.yahoo.com [98.137.64.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46BN0v1gMWzDrBf
 for <linux-erofs@lists.ozlabs.org>; Mon, 19 Aug 2019 02:33:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1566146026; bh=jLjIB1S1BZc9ke0Rkvt8JkIdY+FmHiPvR7jQ8rfSgEE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=NxqzZzhe7/JrNtnNZNJLaUbycF529RdNjPWh1BQiyz6fCUudGypFd79d+xy6SMGHCUFer9KbepCbLco9Kpa8YrjaGO5mi8lshgpXtcuxBF37W4L5+hMXiqgho1STXYLy6PsH8li9aVEAXNfFSRKuFCjgUntl+9Tv8U09W+HcykysadtiEZR54On6PIWWdSeMYbfum6yAIp/i9JG2Yd7TtaTaYaHxMnRnvSNb0+7GOLc8QRu31fEus+I4S7MOAWFbtbqHb6Alf1iMpRQguVz+azmLWK0fTqccEz5MItIyt+qrv+hNIYxrdA9elnZx5CxY0y7rtwgffHnPtVd93e/GZQ==
X-YMail-OSG: IJtAW8QVM1mRuS69bqPHAJpkcTppGPb5LTXO09dPAYGCFnO5LtO1AeLrRdvlw3q
 DGPLtzQCiLPGz7.Aku9H.i4fwJJ1LxNOIfJmFRxVpLSk.NXPbve4JBur0892UPt9gUmtm92lL7OK
 OafMfmKhK2J3.QJ4r1ohWRMzKEfeE8J8hYdPxK6kznAVNTRWsivuCmtBwKVhUE_TX27f8VEVaO0K
 02ibn8iP0muO55ZIzzA4bMtrLbokTVi58.zvPYkr1UwWSss.ul6Xtm5VEx0yfeqAm5_YZbryWeoJ
 eIzg.5Grbawr.saIebp4L.tptU_7ih_SyPGd4q0Lerm1.0.dqz15VYjOZl3An149F2QYCyF_w1Rd
 mfPngSs5V1SsKY7tSvXruPPX5j_IDJAW8.aIZOBzuH2_qVS8Si46p62I9sFuQ.B0X_FZzph5uQ8U
 KgJGUH7.0I55QCt.9yEosFi6VYLlvuMksOTQH2oLePOwUc00.dFZ4a0WBhB3GcS8mVN8XJfc3uYy
 2xO_gzqHceZ_.ZijOEDhUN1KKyiGqTDqdncvtpnD_wlk7nJ0cbY2ImBVOyigFxm4VZBKRqQcvtto
 YxIps6n3VYr2qnEkcYHD5e6ZBAKaOuGTZDxEwRyUNlIGY41Tq0fBz6w1yKqcHICw6zZTSFTs8Qo9
 pb6Apt.gO1lbneXojf84qWy0WuPFE3p95CAsae1xBbOSkU7wLYSv7PQUOTlpZmuWAFu3_o1EKy9M
 jlJho7LhraIFTfWA6D_NcOKL.1eN6yfGy.G6Hlxwx8xG.vYXOehcgQ07crl0NkV482x4lvYr0UwV
 DXV15jw.qFd1bI0S3PU9YUDPCkSOaLXxe4mNMp8yTGt5onmMnF_orOQIf5Leeq1bRchdgkW5Fv0X
 9TmfTBbyX43_7PZ1o7wFQjd9yTd1q0gkDKn51ByOr3SkfQGTou.G0TiwzyDoo5wNgLUWKZ_tDly.
 LYi6e7pN0esbspnff_6NztTIrvfvYcf0AqDM0MZwzfwlT4Sfw9axs2jUlOa6h.1.qkK0r0N2OadB
 4GFx_V56CGiJ0cjBD65w3h4JBAnkX0AtRyeE.ZTRQyceUJPbiNymMol7BlIQ.d5qS8ZTKu0PsYc2
 xjTyDu9xOQ50GxWmQBX2AM5JSjkDc2e60a3V5WL4rCChuHgNKKDGh8RdDSvz3YZIHJ5ITVXUwLCf
 iFvzDsgvgSAK_f3bUCIZ1NG.rrTuEu9N77bIO0Jfa_JH9d40.IbhtzlTrL6jSYDIG02q4gj2CanO
 YIbhsbWL9iyMS9562htwREDtPHpbW5KDp8UPWERA-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.gq1.yahoo.com with HTTP; Sun, 18 Aug 2019 16:33:46 +0000
Received: by smtp425.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID fa33da4732240156c1a7911764ba7d16; 
 Sun, 18 Aug 2019 16:33:41 +0000 (UTC)
Date: Mon, 19 Aug 2019 00:33:25 +0800
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] erofs: move erofs out of staging
Message-ID: <20190818163318.GB31588@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20190817233843.GA16991@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1405781266.69008.1566116210649.JavaMail.zimbra@nod.at>
 <20190818084521.GA17909@hsiangkao-HP-ZHAN-66-Pro-G1>
 <1133002215.69049.1566119033047.JavaMail.zimbra@nod.at>
 <20190818090949.GA30276@kroah.com>
 <790210571.69061.1566120073465.JavaMail.zimbra@nod.at>
 <20190818151154.GA32157@mit.edu>
 <20190818155812.GB13230@infradead.org>
 <20190818161638.GE1118@sol.localdomain>
 <20190818162201.GA16269@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190818162201.GA16269@infradead.org>
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
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 Dave Chinner <david@fromorbit.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
 devel <devel@driverdev.osuosl.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Darrick <darrick.wong@oracle.com>, Richard Weinberger <richard@nod.at>,
 torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Pavel Machek <pavel@denx.de>, David Sterba <dsterba@suse.cz>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-erofs <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Hch,

On Sun, Aug 18, 2019 at 09:22:01AM -0700, Christoph Hellwig wrote:
> On Sun, Aug 18, 2019 at 09:16:38AM -0700, Eric Biggers wrote:
> > Ted's observation was about maliciously-crafted filesystems, though, so
> > integrity-only features such as metadata checksums are irrelevant.  Also the
> > filesystem version is irrelevant; anything accepted by the kernel code (even if
> 
> I think allowing users to mount file systems (any of ours) without
> privilege is a rather bad idea.  But that doesn't mean we should not be
> as robust as we can.  Optionally disabling support for legacy formats
> at compile and/or runtime is something we should actively look into as
> well.
> 
> > it's legacy/deprecated) is open attack surface.
> > 
> > I personally consider it *mandatory* that we deal with this stuff.  But I can
> > understand that we don't do a good job at it, so we shouldn't hold a new
> > filesystem to an unfairly high standard relative to other filesystems...
> 
> I very much disagree.  We can't really force anyone to fix up old file
> systems.  But we can very much hold new ones to (slightly) higher
> standards.  Thats the only way to get the average quality up.  Some as
> for things like code style - we can't magically fix up all old stuff,
> but we can and usually do hold new code to higher standards.  (Often not
> to standards as high as I'd personally prefer, btw).

I personally don't want to discuss about other fses here...

I think XFS developers do great jobs all the time and
EROFS is a simple file system compared with these
generic file systems.

I can promise you that our team will fix bug reports in time, and
I personally think the current EROFS code is not as bad as a bullsh**t...

If you have some time, I'm very happy if you can take some of
your precious time on our work...

Thanks,
Gao Xiang


