Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B22C12BF53
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Dec 2019 22:22:19 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47lc8l5GJhzDqCK
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Dec 2019 08:22:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=ftp.linux.org.uk (client-ip=195.92.253.2;
 helo=zeniv.linux.org.uk; envelope-from=viro@ftp.linux.org.uk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=zeniv.linux.org.uk
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47lc8c6cL6zDq9F
 for <linux-erofs@lists.ozlabs.org>; Sun, 29 Dec 2019 08:22:03 +1100 (AEDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1ilJX2-0004zv-Ox; Sat, 28 Dec 2019 21:21:56 +0000
Date: Sat, 28 Dec 2019 21:21:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Gao Xiang <gaoxiang25@huawei.com>
Subject: Re: [PATCH RESEND] erofs: convert to use the new mount fs_context api
Message-ID: <20191228212156.GU4203@ZenIV.linux.org.uk>
References: <20191226022519.53386-1-yuchao0@huawei.com>
 <20191227035016.GA142350@architecture4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227035016.GA142350@architecture4>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 David Howells <dhowells@redhat.com>, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Dec 27, 2019 at 11:50:16AM +0800, Gao Xiang wrote:
> Hi Al,
> 
> Greeting, we plan to convert erofs to new mount api for 5.6
> 
> and I just notice your branch
> https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=untested.fs_parse
> 
> do a lot further work on fs context (e.g. "get rid of ->enums",
> "remove fs_parameter_description name field" and switch to
> use XXXfc() instead of XXXf() with prefixed string).
> 
> Does it plan for 5.6 as well? If yes, we will update this patch
> based on the latest branch and maybe have chance to go though
> your tree if it can?

FWIW, I would add the following to what you've already mentioned:

> > +static const struct fs_parameter_spec erofs_param_specs[] = {
> > +	fsparam_flag("user_xattr",	Opt_user_xattr),
> > +	fsparam_flag("nouser_xattr",	Opt_nouser_xattr),
> > +	fsparam_flag("acl",		Opt_acl),
> > +	fsparam_flag("noacl",		Opt_noacl),
better off as
	fsparam_flag_no("user_xattr",	Opt_user_xattr),
	fsparam_flag_no("acl",		Opt_acl),

> > +	case Opt_user_xattr:
		if (result.boolean)
			set_opt(sbi, XATTR_USER);
		else
			clear_opt(sbi, XATTR_USER);
> > +		break;
....
> > +	default:
		return -ENOPARAM;

BTW, what's the point of using invalf() in contexts where
the return value is ignored?  Why not simply go for errorf()
(or errorfc(), for that matter)?

I do plan that branch (or an equivalent, as far as filesystems
are concerned - there might be a bit of additional rework in
the beginning + currently missing modifications of docs) for
5.6.  So updated patch would be welcome - I can do that myself,
but if you can rebase it on top of that branch it would save
time.
