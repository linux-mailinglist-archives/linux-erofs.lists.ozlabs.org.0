Return-Path: <linux-erofs+bounces-2545-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKziLffIrmlwIwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2545-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 14:19:51 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C274023996D
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 14:19:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fTyKb0t1Tz309P;
	Tue, 10 Mar 2026 00:19:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773062387;
	cv=none; b=hYZFNiczzoyDQvSxnERrS5n5m4MjjWqzfQMt4eiLLMqB7DE5Un8MJXtMiveJJ27cNRvFjnlj3KRkvmlRIGdQjRIHMuoCC1rgJaUM0wjHMgY/5u1TehIakWNNTf/Ojk0+FUX3QcRUUM8ZQZwVyCFPRorQqJ4LHSXhYgXOeK8C/1BsqhOtgrsprU52YqxiRBY9vNdYAJHj58/4ymuJERvg67PM0Fy8PDop7iGUWlG15s/N2ZnXa8BqKd+BMZ5SPu+YPEkS4w59MXVkF1c2qblWC4f/MiG+tc0/kR0CADgOaxCDWOkJyd13MglYfTWJprBiIvFnVyQzE9bG6qLG7aoAow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773062387; c=relaxed/relaxed;
	bh=TT/1bYm1dwRQZUPFZgVug+I9OLpG8KAv6cj/Pd2b+bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QyE8a/w4oYh5F5xA7Pu0s87yMAvepPgQYN4sDOZkvY2mN/xgygX//LKsWB3g9XzcWmhLdz47hpMLqG11gdoaC8rfx4Ny19WEwyKlIOnqK89zjrHH5uqmjZdhYkSQG/d6CdLQ5eg4bNGmfWhe0e65Ve3SNXf4u0jXdHrWTUR+2JH99Tb9YpUUU2ATMCYPPT3QVhG1eiEk+cPbTWQiHRH5Q9Q3NzZhhDzMhkFhqHGRsclGNDrzk7NQP9DEsVCl9o5tMtxMxfs2LrsYhu2/nTwhUf8vRYFfddYoiN2jYgsa9Y0WJKymNmgERsvk5PWAXqIqYc0qT13GF9ilI9oh/i4mJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Bn6XQwcP; dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ze4Ub3DI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Bn6XQwcP; dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ze4Ub3DI; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Bn6XQwcP;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ze4Ub3DI;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Bn6XQwcP;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ze4Ub3DI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fTyKY1MLhz2ySb
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Mar 2026 00:19:45 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 34B9E4D21E;
	Mon,  9 Mar 2026 13:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773062378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TT/1bYm1dwRQZUPFZgVug+I9OLpG8KAv6cj/Pd2b+bI=;
	b=Bn6XQwcPXAgwu0+tSZyNzhttjDFeOR8MgizI8c7TE36XXQ5/qv0/SOLJZViesyAbUs4m7n
	G5vzmrh/VgV7OuDguf4Ab8mImUTSnvyR/zW0O5NYeanX2IOqE0EjcCkQ6r8U3O3nQLbkvz
	cV1sGL6vaCGsrjf25OI9UGQbEvlM9P0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773062378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TT/1bYm1dwRQZUPFZgVug+I9OLpG8KAv6cj/Pd2b+bI=;
	b=ze4Ub3DItqqlILMfCsqWQFJzHzBwV3g0ipMqNzhypHKLV4rlb4YFMWn3aMNpA0sM1CthKr
	tUvOz6TStNYmkaBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773062378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TT/1bYm1dwRQZUPFZgVug+I9OLpG8KAv6cj/Pd2b+bI=;
	b=Bn6XQwcPXAgwu0+tSZyNzhttjDFeOR8MgizI8c7TE36XXQ5/qv0/SOLJZViesyAbUs4m7n
	G5vzmrh/VgV7OuDguf4Ab8mImUTSnvyR/zW0O5NYeanX2IOqE0EjcCkQ6r8U3O3nQLbkvz
	cV1sGL6vaCGsrjf25OI9UGQbEvlM9P0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773062378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TT/1bYm1dwRQZUPFZgVug+I9OLpG8KAv6cj/Pd2b+bI=;
	b=ze4Ub3DItqqlILMfCsqWQFJzHzBwV3g0ipMqNzhypHKLV4rlb4YFMWn3aMNpA0sM1CthKr
	tUvOz6TStNYmkaBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2502D3EEFF;
	Mon,  9 Mar 2026 13:19:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w5wBCerIrmlXfQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Mar 2026 13:19:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DDFD9A09A4; Mon,  9 Mar 2026 14:19:33 +0100 (CET)
Date: Mon, 9 Mar 2026 14:19:33 +0100
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Chao Yu <chao@kernel.org>, 
	xiang@kernel.org, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
	Sandeep Dhavale <dhavale@google.com>, Chunhai Guo <guochunhai@vivo.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] erofs: introduce nolargefolio mount option
Message-ID: <tofvy7pnryumcbar5s5gqt7245ynfzwurhnl742zj6bdruyay6@kk6myv2r6w3r>
References: <20260309023053.1685839-1-chao@kernel.org>
 <02925ac8-64a6-4cd6-bbd4-c37d838f862a@linux.alibaba.com>
 <aa7FJfgwkdXlifJX@casper.infradead.org>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa7FJfgwkdXlifJX@casper.infradead.org>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: C274023996D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2545-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:willy@infradead.org,m:hsiangkao@linux.alibaba.com,m:chao@kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:guochunhai@vivo.com,m:lihongbo22@huawei.com,m:jack@suse.cz,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER(0.00)[jack@suse.cz,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[linux.alibaba.com,kernel.org,lists.ozlabs.org,vger.kernel.org,gmail.com,google.com,vivo.com,huawei.com,suse.cz];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlesource.com:url,lists.ozlabs.org:rdns,lists.ozlabs.org:helo,suse.com:email]
X-Rspamd-Action: no action

On Mon 09-03-26 13:03:33, Matthew Wilcox wrote:
> On Mon, Mar 09, 2026 at 11:03:43AM +0800, Gao Xiang wrote:
> > Hi Chao,
> > 
> > (+cc -fsdevel, willy, Jan kara)
> > 
> > On 2026/3/9 10:30, Chao Yu wrote:
> > > This patch introduces a new mount option 'nolargefolio' for EROFS.
> > > When this option is specified, large folio will be disabled by
> > > default for all inodes, this option can be used for environments
> > > where large folio resources are limited, it's necessary to only
> > > let specified user to allocate large folios on demand.
> > 
> > For this kind of options, I think more real backgrounds
> > about avoiding high-order allocations are needed in the
> > commit message (at least for later reference) also like
> > what I observed in:
> > https://android-review.googlesource.com/c/kernel/common/+/3877981
> > 
> > because the entire community tends to enable large folios
> > unconditionally if possible.  Without enough clarification,
> > even I merge this, there will be endless questions again
> > and again about this.
> 
> This was a decision made early on.  If the heuristics are wrong, they
> need to be fixed.  It's very disappointing to see people try to sneak
> these changes into individual filesystems.  Thanks for catching it and
> preventing it from sneaking in.  Chao is not a new contributor; he
> should know better than this by now.

I agree improving the heuristics is much better (fixes the problem for
everyone) than disabling large folios (even more so on per-fs basis). As
I'm rereading the old thread Gao referenced the concern here is about small
(as in below 1g of memory) devices where apparently the memory overhead of
large folios hurts significantly. Perhaps we could tune the folio order we
allocate based on the current size of the page cache on the device or
something like that?

								Honza

> > And Jan once raised up if it should be a user interface
> > or auto-tuning one:
> > https://lore.kernel.org/r/z2ule3ilnnpoevo5mvt3intvjtuyud7vg3pbfauon47fhr4owa@giaehpbie4a5
> > 
> > My question is that if the needs are real, I wonder if
> > it should be a vfs generic decision instead (because
> > it's not due to the filesystem restriction but due to
> > real system memory pressure or heavy workload for
> > example).  However, if the answer is that others don't
> > really care about this, I'm fine to leave it as an
> > erofs-specific option as long as the actual case is
> > clear in the commit message.
> > 
> > Thanks,
> > Gao Xiang
> > 
> > 
> > > 
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > >   Documentation/filesystems/erofs.rst | 1 +
> > >   fs/erofs/inode.c                    | 3 ++-
> > >   fs/erofs/internal.h                 | 1 +
> > >   fs/erofs/super.c                    | 8 +++++++-
> > >   4 files changed, 11 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> > > index fe06308e546c..d692a1d9f32c 100644
> > > --- a/Documentation/filesystems/erofs.rst
> > > +++ b/Documentation/filesystems/erofs.rst
> > > @@ -137,6 +137,7 @@ fsoffset=%llu          Specify block-aligned filesystem offset for the primary d
> > >   inode_share            Enable inode page sharing for this filesystem.  Inodes with
> > >                          identical content within the same domain ID can share the
> > >                          page cache.
> > > +nolargefolio           Disable large folio support for all files.
> > >   ===================    =========================================================
> > >   Sysfs Entries
> > > diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> > > index 4b3d21402e10..26361e86a354 100644
> > > --- a/fs/erofs/inode.c
> > > +++ b/fs/erofs/inode.c
> > > @@ -254,7 +254,8 @@ static int erofs_fill_inode(struct inode *inode)
> > >   		return 0;
> > >   	}
> > > -	mapping_set_large_folios(inode->i_mapping);
> > > +	if (!test_opt(&EROFS_SB(inode->i_sb)->opt, NO_LARGE_FOLIO))
> > > +		mapping_set_large_folios(inode->i_mapping);
> > >   	aops = erofs_get_aops(inode, false);
> > >   	if (IS_ERR(aops))
> > >   		return PTR_ERR(aops);
> > > diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> > > index a4f0a42cf8c3..b5d98410c699 100644
> > > --- a/fs/erofs/internal.h
> > > +++ b/fs/erofs/internal.h
> > > @@ -177,6 +177,7 @@ struct erofs_sb_info {
> > >   #define EROFS_MOUNT_DAX_NEVER		0x00000080
> > >   #define EROFS_MOUNT_DIRECT_IO		0x00000100
> > >   #define EROFS_MOUNT_INODE_SHARE		0x00000200
> > > +#define EROFS_MOUNT_NO_LARGE_FOLIO	0x00000400
> > >   #define clear_opt(opt, option)	((opt)->mount_opt &= ~EROFS_MOUNT_##option)
> > >   #define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
> > > diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> > > index 972a0c82198d..a353369d4db8 100644
> > > --- a/fs/erofs/super.c
> > > +++ b/fs/erofs/super.c
> > > @@ -390,7 +390,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
> > >   enum {
> > >   	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
> > >   	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio, Opt_fsoffset,
> > > -	Opt_inode_share,
> > > +	Opt_inode_share, Opt_nolargefolio,
> > >   };
> > >   static const struct constant_table erofs_param_cache_strategy[] = {
> > > @@ -419,6 +419,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
> > >   	fsparam_flag_no("directio",	Opt_directio),
> > >   	fsparam_u64("fsoffset",		Opt_fsoffset),
> > >   	fsparam_flag("inode_share",	Opt_inode_share),
> > > +	fsparam_flag("nolargefolio",	Opt_nolargefolio),
> > >   	{}
> > >   };
> > > @@ -541,6 +542,9 @@ static int erofs_fc_parse_param(struct fs_context *fc,
> > >   		else
> > >   			set_opt(&sbi->opt, INODE_SHARE);
> > >   		break;
> > > +	case Opt_nolargefolio:
> > > +		set_opt(&sbi->opt, NO_LARGE_FOLIO);
> > > +		break;
> > >   	}
> > >   	return 0;
> > >   }
> > > @@ -1105,6 +1109,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
> > >   		seq_printf(seq, ",fsoffset=%llu", sbi->dif0.fsoff);
> > >   	if (test_opt(opt, INODE_SHARE))
> > >   		seq_puts(seq, ",inode_share");
> > > +	if (test_opt(opt, NO_LARGE_FOLIO))
> > > +		seq_puts(seq, ",nolargefolio");
> > >   	return 0;
> > >   }
> > 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

