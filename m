Return-Path: <linux-erofs+bounces-2544-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEU0KzvFrmn2IgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2544-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 14:03:55 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 055D22395E3
	for <lists+linux-erofs@lfdr.de>; Mon, 09 Mar 2026 14:03:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fTxzC6zTDz3bnm;
	Tue, 10 Mar 2026 00:03:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773061431;
	cv=none; b=NYaxwT9q+fr/n+fGw5HJhQgE/KJwLzHUvDH24GUzl7M+W7ccejlQKGGl54yeE9p8xT/cFQy3XHb8n5gng8A0nvz+I/dEuHVJCR5BZ0MOCSE6r1q2OnnUBJgjmLAdiZ7LedAiUN+Mj/bVV60YbQ9JigNlyy5ePMrPCtotsjWZbn6iGx/k8pQcxrfOVb8CAcunB6HBy17MKBRHn+de7AMHdwjKjcbKa9lDXiWTQl4+ia2rwHefMbU6Qxidw0MAKPVHmXfRVENve/sWp6C1Oy5UdGIpyFnl95dwnW1ScL/s53MbUaKLNfFOKi/buImjaTYAuqPMirxJMYNJA3AEluEEjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773061431; c=relaxed/relaxed;
	bh=31L+FqXjA9EQYwvqJDRlkc1ufhApxWyjZUFXmPO4kyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ5IwD+CTNfUAsvXvTTCNhSw0zBPlw2mhgkURTwlMx+GA+b1zdSNOBWxHGQhKQinoJjTMX2sJPS/SbuUjyJzhSR6AnnbvMQwsh8SVEEx9jo+95onkGryRMQA+owefde0uHT9Gpbp2IOo18CvI/nUnuStWLUKqd5S4sB7QuHa0BLWdYlfLn0ILc6V0MsizNeikC/5Ev8vasJQ9cfUpNR0KVxm9EAL2rh2RNoY6DRP8pUpOI2izCFwdaJBsoiCETmxj8ZZcPTYsjTwCwbv6PI8tScpI2LMxEfPvjju23D1WWxraM/Bvbtf0UAFW3c+gaG1c48OfD57RgSz5FkCPYrU5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=wUbFTL8q; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=wUbFTL8q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fTxz66YYyz2ySb
	for <linux-erofs@lists.ozlabs.org>; Tue, 10 Mar 2026 00:03:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=31L+FqXjA9EQYwvqJDRlkc1ufhApxWyjZUFXmPO4kyo=; b=wUbFTL8qq30tSQVJq3ehcYQJoe
	uOZaGIefAhIY4RzRkPNn5HRPSP3a3alribkOgWKM+6MXdt7p2OfIx6M50Qc2mYfK3vcDJVlgoIzEP
	Wu8li/RWq6cFOJUt5fjGOQM+3xLQ36GtSBG7mRaC8sjN1i1VctXLOtZK2RVsvTpuAG2/Oexwdo7Dn
	sR1T7RYrKUvPdnUwpivZwJ9i03LE8qMaU3DdsdektN9ZUd0MzlrN5a9jJaHGjQ3YS9aMCTV94LCDr
	7c+kC0Cdql1pQvpQEEB8H18cUk+nVJItpT/BveaT4IjvEV4JSriGKXwOELHVd98sj6sqKSrjah82P
	xT74puWw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzaGk-00000005YcO-06Ql;
	Mon, 09 Mar 2026 13:03:34 +0000
Date: Mon, 9 Mar 2026 13:03:33 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Chao Yu <chao@kernel.org>, xiang@kernel.org,
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	Hongbo Li <lihongbo22@huawei.com>, Jan Kara <jack@suse.cz>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] erofs: introduce nolargefolio mount option
Message-ID: <aa7FJfgwkdXlifJX@casper.infradead.org>
References: <20260309023053.1685839-1-chao@kernel.org>
 <02925ac8-64a6-4cd6-bbd4-c37d838f862a@linux.alibaba.com>
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
In-Reply-To: <02925ac8-64a6-4cd6-bbd4-c37d838f862a@linux.alibaba.com>
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 055D22395E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2544-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.ozlabs.org,vger.kernel.org,gmail.com,linux.alibaba.com,google.com,vivo.com,huawei.com,suse.cz];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:chao@kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:guochunhai@vivo.com,m:lihongbo22@huawei.com,m:jack@suse.cz,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[willy@infradead.org,linux-erofs@lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlesource.com:url,casper.infradead.org:mid,lists.ozlabs.org:rdns,lists.ozlabs.org:helo,infradead.org:dkim]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 11:03:43AM +0800, Gao Xiang wrote:
> Hi Chao,
> 
> (+cc -fsdevel, willy, Jan kara)
> 
> On 2026/3/9 10:30, Chao Yu wrote:
> > This patch introduces a new mount option 'nolargefolio' for EROFS.
> > When this option is specified, large folio will be disabled by
> > default for all inodes, this option can be used for environments
> > where large folio resources are limited, it's necessary to only
> > let specified user to allocate large folios on demand.
> 
> For this kind of options, I think more real backgrounds
> about avoiding high-order allocations are needed in the
> commit message (at least for later reference) also like
> what I observed in:
> https://android-review.googlesource.com/c/kernel/common/+/3877981
> 
> because the entire community tends to enable large folios
> unconditionally if possible.  Without enough clarification,
> even I merge this, there will be endless questions again
> and again about this.

This was a decision made early on.  If the heuristics are wrong, they
need to be fixed.  It's very disappointing to see people try to sneak
these changes into individual filesystems.  Thanks for catching it and
preventing it from sneaking in.  Chao is not a new contributor; he
should know better than this by now.

> And Jan once raised up if it should be a user interface
> or auto-tuning one:
> https://lore.kernel.org/r/z2ule3ilnnpoevo5mvt3intvjtuyud7vg3pbfauon47fhr4owa@giaehpbie4a5
> 
> My question is that if the needs are real, I wonder if
> it should be a vfs generic decision instead (because
> it's not due to the filesystem restriction but due to
> real system memory pressure or heavy workload for
> example).  However, if the answer is that others don't
> really care about this, I'm fine to leave it as an
> erofs-specific option as long as the actual case is
> clear in the commit message.
> 
> Thanks,
> Gao Xiang
> 
> 
> > 
> > Signed-off-by: Chao Yu <chao@kernel.org>
> > ---
> >   Documentation/filesystems/erofs.rst | 1 +
> >   fs/erofs/inode.c                    | 3 ++-
> >   fs/erofs/internal.h                 | 1 +
> >   fs/erofs/super.c                    | 8 +++++++-
> >   4 files changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
> > index fe06308e546c..d692a1d9f32c 100644
> > --- a/Documentation/filesystems/erofs.rst
> > +++ b/Documentation/filesystems/erofs.rst
> > @@ -137,6 +137,7 @@ fsoffset=%llu          Specify block-aligned filesystem offset for the primary d
> >   inode_share            Enable inode page sharing for this filesystem.  Inodes with
> >                          identical content within the same domain ID can share the
> >                          page cache.
> > +nolargefolio           Disable large folio support for all files.
> >   ===================    =========================================================
> >   Sysfs Entries
> > diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> > index 4b3d21402e10..26361e86a354 100644
> > --- a/fs/erofs/inode.c
> > +++ b/fs/erofs/inode.c
> > @@ -254,7 +254,8 @@ static int erofs_fill_inode(struct inode *inode)
> >   		return 0;
> >   	}
> > -	mapping_set_large_folios(inode->i_mapping);
> > +	if (!test_opt(&EROFS_SB(inode->i_sb)->opt, NO_LARGE_FOLIO))
> > +		mapping_set_large_folios(inode->i_mapping);
> >   	aops = erofs_get_aops(inode, false);
> >   	if (IS_ERR(aops))
> >   		return PTR_ERR(aops);
> > diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> > index a4f0a42cf8c3..b5d98410c699 100644
> > --- a/fs/erofs/internal.h
> > +++ b/fs/erofs/internal.h
> > @@ -177,6 +177,7 @@ struct erofs_sb_info {
> >   #define EROFS_MOUNT_DAX_NEVER		0x00000080
> >   #define EROFS_MOUNT_DIRECT_IO		0x00000100
> >   #define EROFS_MOUNT_INODE_SHARE		0x00000200
> > +#define EROFS_MOUNT_NO_LARGE_FOLIO	0x00000400
> >   #define clear_opt(opt, option)	((opt)->mount_opt &= ~EROFS_MOUNT_##option)
> >   #define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
> > diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> > index 972a0c82198d..a353369d4db8 100644
> > --- a/fs/erofs/super.c
> > +++ b/fs/erofs/super.c
> > @@ -390,7 +390,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
> >   enum {
> >   	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
> >   	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio, Opt_fsoffset,
> > -	Opt_inode_share,
> > +	Opt_inode_share, Opt_nolargefolio,
> >   };
> >   static const struct constant_table erofs_param_cache_strategy[] = {
> > @@ -419,6 +419,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
> >   	fsparam_flag_no("directio",	Opt_directio),
> >   	fsparam_u64("fsoffset",		Opt_fsoffset),
> >   	fsparam_flag("inode_share",	Opt_inode_share),
> > +	fsparam_flag("nolargefolio",	Opt_nolargefolio),
> >   	{}
> >   };
> > @@ -541,6 +542,9 @@ static int erofs_fc_parse_param(struct fs_context *fc,
> >   		else
> >   			set_opt(&sbi->opt, INODE_SHARE);
> >   		break;
> > +	case Opt_nolargefolio:
> > +		set_opt(&sbi->opt, NO_LARGE_FOLIO);
> > +		break;
> >   	}
> >   	return 0;
> >   }
> > @@ -1105,6 +1109,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
> >   		seq_printf(seq, ",fsoffset=%llu", sbi->dif0.fsoff);
> >   	if (test_opt(opt, INODE_SHARE))
> >   		seq_puts(seq, ",inode_share");
> > +	if (test_opt(opt, NO_LARGE_FOLIO))
> > +		seq_puts(seq, ",nolargefolio");
> >   	return 0;
> >   }
> 

