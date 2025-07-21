Return-Path: <linux-erofs+bounces-688-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DCAB0C13B
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Jul 2025 12:26:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4blxPh4tn7z2xKd;
	Mon, 21 Jul 2025 20:26:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753093560;
	cv=none; b=I9CfUF5A/hcC/2H5JiVv2xx5O4drVXWl2JfNPaCovXRv29kj3NDZYs13QWS3bkQ7adPCs2LzrtG38PChKoAsONDiBdGNvELKaylp/OI9wl69tu0HnuC2qm5H2Rbzrs9hTK4unMRpM7ItpBKruIoZfZYZNvEZMAIernW2oNHPwGkbhd5m9TETzvhKsgcisim0iQmJxCjG5Ht38k1clecMiSMtIa5iTnNetrPdHpneFGYSQMpBhxU834MtNh2erDI5x5z9RyrUet8PDNIfBD5ZvlQo/I/R/L9rEbU/jf6v+rgwOa9rS5xntadij8kxXyD2Y6886rVtnwcnEfrM9+HYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753093560; c=relaxed/relaxed;
	bh=baH6ow82NzmU1jGwAd7SMMrxH3jdioo5q/Xo9G5hG+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVwz+MCPsxNm+Cm6Q81HEbuVkrB+RWPkthSyKsBLKInWg/MpDPoVLUF1+N6FLH/fmy8x8+c5OZiocz7vmcJKE/KsQQWp+10u7EVVTva+CqGT0jj3q5phRW3KRahZPl/8Czj7+r0gm8FHuToEBj5hGPEs0yifnpYYIlhIG+/VbNmyL5/82u/IosC75Z1qS85sK4PeHdZ30ablIRQA+1QYn4KB5OrnvaFYSFaA1KZQbiSxo4sGUUiaB4I+izT14A/lOmbL917gHJyfDAfncCnlJfXaQXy6is5VFXuMpZW32oTqleWZaIrBRImxnZjrE676c7AFVpLXq10q7XcSvBcJ6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz; dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=GGCpmZZg; dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TiuaNzkK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=GGCpmZZg; dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TiuaNzkK; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org) smtp.mailfrom=suse.cz
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=GGCpmZZg;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TiuaNzkK;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=GGCpmZZg;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TiuaNzkK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=jack@suse.cz; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4blxPf6Tvrz2xHp
	for <linux-erofs@lists.ozlabs.org>; Mon, 21 Jul 2025 20:25:58 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 51A1E1F397;
	Mon, 21 Jul 2025 10:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753093555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=baH6ow82NzmU1jGwAd7SMMrxH3jdioo5q/Xo9G5hG+4=;
	b=GGCpmZZgbAB5XlOhPaT/l0zeSwhiqSn6JbNbcSAdSIrsIWr7T0Mc7Nurq9TLL5MlDIKSzb
	G3mxxnF5X/WFL2F9PDn8NfEprPokB+uugrjkHFG+jVRlyIUBsFn+89vrEh51dQKAspuIIa
	bOQxVSvP+dassyYss7hQFywZfgAWP9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753093555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=baH6ow82NzmU1jGwAd7SMMrxH3jdioo5q/Xo9G5hG+4=;
	b=TiuaNzkKooiGvnBZgx/DGGdlv5vk/tkXPxkZgwh1y7czyZp1RZa8jl8Z3vpXSlkZ0+KbS8
	LZDo/WglGtJ31cBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GGCpmZZg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TiuaNzkK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753093555; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=baH6ow82NzmU1jGwAd7SMMrxH3jdioo5q/Xo9G5hG+4=;
	b=GGCpmZZgbAB5XlOhPaT/l0zeSwhiqSn6JbNbcSAdSIrsIWr7T0Mc7Nurq9TLL5MlDIKSzb
	G3mxxnF5X/WFL2F9PDn8NfEprPokB+uugrjkHFG+jVRlyIUBsFn+89vrEh51dQKAspuIIa
	bOQxVSvP+dassyYss7hQFywZfgAWP9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753093555;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=baH6ow82NzmU1jGwAd7SMMrxH3jdioo5q/Xo9G5hG+4=;
	b=TiuaNzkKooiGvnBZgx/DGGdlv5vk/tkXPxkZgwh1y7czyZp1RZa8jl8Z3vpXSlkZ0+KbS8
	LZDo/WglGtJ31cBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3453C13A88;
	Mon, 21 Jul 2025 10:25:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Lyt7DLMVfmi/GgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 21 Jul 2025 10:25:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5D047A0884; Mon, 21 Jul 2025 12:25:54 +0200 (CEST)
Date: Mon, 21 Jul 2025 12:25:54 +0200
From: Jan Kara <jack@suse.cz>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Barry Song <21cnbao@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org, 
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, 
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, 
	David Howells <dhowells@redhat.com>, netfs@lists.linux.dev, Paulo Alcantara <pc@manguebit.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, ntfs3@lists.linux.dev, Steve French <sfrench@samba.org>, 
	linux-cifs@vger.kernel.org, Phillip Lougher <phillip@squashfs.org.uk>, 
	Hailong Liu <hailong.liu@oppo.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Compressed files & the page cache
Message-ID: <z2ule3ilnnpoevo5mvt3intvjtuyud7vg3pbfauon47fhr4owa@giaehpbie4a5>
References: <aHa8ylTh0DGEQklt@casper.infradead.org>
 <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
 <b61c4b7f-4bb1-4551-91ba-a0e0ffd19e75@linux.alibaba.com>
 <CAGsJ_4xJjwsvMpeBV-QZFoSznqhiNSFtJu9k6da_T-T-a6VwNw@mail.gmail.com>
 <7ea73f49-df4b-4f88-8b23-c917b4a9bd8a@linux.alibaba.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ea73f49-df4b-4f88-8b23-c917b4a9bd8a@linux.alibaba.com>
X-Spam-Level: 
X-Rspamd-Queue-Id: 51A1E1F397
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL76kpr34nasjgd69zbi7paxtw)];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,infradead.org,fb.com,toxicpanda.com,suse.com,vger.kernel.org,fluxnic.net,kernel.org,lists.ozlabs.org,lists.sourceforge.net,suse.cz,nod.at,lists.infradead.org,redhat.com,lists.linux.dev,manguebit.org,paragon-software.com,samba.org,squashfs.org.uk,oppo.com,gmx.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -4.01
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon 21-07-25 11:14:02, Gao Xiang wrote:
> Hi Barry,
> 
> On 2025/7/21 09:02, Barry Song wrote:
> > On Wed, Jul 16, 2025 at 8:28 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > > 
> 
> ...
> 
> > > 
> > > ... high-order folios can cause side effects on embedded devices
> > > like routers and IoT devices, which still have MiBs of memory (and I
> > > believe this won't change due to their use cases) but they also use
> > > Linux kernel for quite long time.  In short, I don't think enabling
> > > large folios for those devices is very useful, let alone limiting
> > > the minimum folio order for them (It would make the filesystem not
> > > suitable any more for those users.  At least that is what I never
> > > want to do).  And I believe this is different from the current LBS
> > > support to match hardware characteristics or LBS atomic write
> > > requirement.
> > 
> > Given the difficulty of allocating large folios, it's always a good
> > idea to have order-0 as a fallback. While I agree with your point,
> > I have a slightly different perspective — enabling large folios for
> > those devices might be beneficial, but the maximum order should
> > remain small. I'm referring to "small" large folios.
> 
> Yeah, agreed. Having a way to limit the maximum order for those small
> devices (rather than disabling it completely) would be helpful.  At
> least "small" large folios could still provide benefits when memory
> pressure is light.

Well, in the page cache you can tune not only the minimum but also the
maximum order of a folio being allocated for each inode. Btrfs and ext4
already use this functionality. So in principle the functionality is there,
it is "just" a question of proper user interfaces or automatic logic to
tune this limit.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

