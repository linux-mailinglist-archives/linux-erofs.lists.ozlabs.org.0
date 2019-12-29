Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 281EE12BFFF
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Dec 2019 03:46:49 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47llM96gf0zDqCw
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Dec 2019 13:46:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1577587605;
	bh=Iwb1usuaa8ouq7ZsyLIt0MsGUMHPwgsczIln4/79Gps=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=F5coh1xzMrHcNM8FwWx2L5/t2RKqa62Z3hu3oR8RbPUQXnKi8Z486J/pQRmexD2el
	 wgi6sjSQrOQuAcJbBq4+bUeM2ZS6R2ktYilpJ8XqF1Wxw6QYuf8fUdlu35C35PX9SQ
	 arQ9wYZgealkGTAQDqiVs4A8Ja6g2YAcsz17pRe/h5Q0KjMpwTyFz54S2C70EG6G5H
	 DRj2kKPHSMStM0LQkgs1Lk9v9lO5zBTidO4v4gtnStsYdjLowyCo26Bu/4HFyBdU3y
	 L9GB/SvfoGZcmpjKYk2zDcx0gs+LPdbT2gkeKhEdNEopzN7ZWHm1DmMOBCi+XtaOZx
	 slDtjCBPxAU1g==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.232; helo=sonic303-50.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="uFXDgE/6"; 
 dkim-atps=neutral
Received: from sonic303-50.consmr.mail.gq1.yahoo.com
 (sonic303-50.consmr.mail.gq1.yahoo.com [98.137.64.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47llLq46V6zDq9Z
 for <linux-erofs@lists.ozlabs.org>; Sun, 29 Dec 2019 13:46:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1577587580; bh=6/Q6SNynxNQ8G8c617T7+WEqsKRr7oL+1YtlRaUeq+g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=uFXDgE/66xF3EsVJ5mGL8atE1oRVvcYc6hPaDiBcac66mzEHDWyJ8RhU3AmPuSlOxO8e0TwAFolvxlm3CMZ/snPwUa5Rtrx06Z+y/Hi1e66j5CbsllR/gzCnrSe/Jja7OLU5BwLnGStWQJwhVccBDTfaHyPP8tbbHXXW3PpAvqZasMJ3gzDSYt50VVZuedsHjduwJlRWMATPZMUkO52QBn5rfUWP5bz+JLtXE0Tvw4xkt4ggyl7uu0Rn1b2MzFhbaCg1Nf31LxmP3tK6PqfTzJP71i+7vxQssSjipJ9lAndoXSxUf9zGNflDuEuh6/Kj9pZbm6rqVo3y+xJKwiogQA==
X-YMail-OSG: N_6BpMEVRDvd.miR6A7lED5GPdAEx7ojsA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.gq1.yahoo.com with HTTP; Sun, 29 Dec 2019 02:46:20 +0000
Received: by smtp424.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 9f863a345b562991edc35c48481656f9; 
 Sun, 29 Dec 2019 02:44:18 +0000 (UTC)
Date: Sun, 29 Dec 2019 10:44:08 +0800
To: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH RESEND] erofs: convert to use the new mount fs_context api
Message-ID: <20191229024406.GA2215@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20191226022519.53386-1-yuchao0@huawei.com>
 <20191227035016.GA142350@architecture4>
 <20191228212156.GU4203@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191228212156.GU4203@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4
 (Java/1.8.0_181)
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
Cc: David Howells <dhowells@redhat.com>, linux-erofs@lists.ozlabs.org,
 Miao Xie <miaoxie@huawei.com>, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sat, Dec 28, 2019 at 09:21:56PM +0000, Al Viro wrote:
> On Fri, Dec 27, 2019 at 11:50:16AM +0800, Gao Xiang wrote:
> > Hi Al,
> > 
> > Greeting, we plan to convert erofs to new mount api for 5.6
> > 
> > and I just notice your branch
> > https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=untested.fs_parse
> > 
> > do a lot further work on fs context (e.g. "get rid of ->enums",
> > "remove fs_parameter_description name field" and switch to
> > use XXXfc() instead of XXXf() with prefixed string).
> > 
> > Does it plan for 5.6 as well? If yes, we will update this patch
> > based on the latest branch and maybe have chance to go though
> > your tree if it can?
> 
> FWIW, I would add the following to what you've already mentioned:

Thanks for your reply and confirmation.

> 
> > > +static const struct fs_parameter_spec erofs_param_specs[] = {
> > > +	fsparam_flag("user_xattr",	Opt_user_xattr),
> > > +	fsparam_flag("nouser_xattr",	Opt_nouser_xattr),
> > > +	fsparam_flag("acl",		Opt_acl),
> > > +	fsparam_flag("noacl",		Opt_noacl),
> better off as
> 	fsparam_flag_no("user_xattr",	Opt_user_xattr),
> 	fsparam_flag_no("acl",		Opt_acl),

Got it. We didn't notice this new way. Will fix in the updated version.

> 
> > > +	case Opt_user_xattr:
> 		if (result.boolean)
> 			set_opt(sbi, XATTR_USER);
> 		else
> 			clear_opt(sbi, XATTR_USER);
> > > +		break;
> ....
> > > +	default:
> 		return -ENOPARAM;

Got it.

> 
> BTW, what's the point of using invalf() in contexts where
> the return value is ignored?  Why not simply go for errorf()
> (or errorfc(), for that matter)?

OK, We will check all invalf()s soon.

And may I ask one more question about this... I'm a bit confused,
since we have erofs_err() which print sb->s_id as well, so which
one (errorfc or erofs_err) is more perferred to choose in especially
fill_super()?

> 
> I do plan that branch (or an equivalent, as far as filesystems
> are concerned - there might be a bit of additional rework in
> the beginning + currently missing modifications of docs) for
> 5.6.  So updated patch would be welcome - I can do that myself,
> but if you can rebase it on top of that branch it would save
> time.

Yes, we will update this patch based on the latest branch later
for this convert.

Thanks,
Gao Xiang


