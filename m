Return-Path: <linux-erofs+bounces-2999-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMH0DTH4w2nPvAQAu9opvQ
	(envelope-from <linux-erofs+bounces-2999-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 15:58:57 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56977327509
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 15:58:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgqmZ07fFz2xlf;
	Thu, 26 Mar 2026 01:58:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774450733;
	cv=none; b=cWVCUJ66BDU+LCLZa9+qtf56f7UyK8nsPHK8TbabMbSxY0qRQM3cNDMQy93TsdMvmijc0PIdIXrL2royQDPV79fRhSMAYbS/2Wb6ymXgNE2aIbQ2tlREw/PaKe5ONApgvj2nrH1lavIOcd1YvPd4fTlLX13qxT9zOsjaO0Xb3Wb6a8D8bR+neO+gDVcDY34ru9hxA+5FZeNXlILLu67ZDfEUGGVX+nfP3uAw53BO7AoubUcC0L58iBMLD9cgF/yjroEE6p6CDhA4o4nysRL79bokHtSGTyeKez01TIoD5O/u3uJiZPBWcc+NDgIfkQsHIyZDrtIABYfhAJymA6JAjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774450733; c=relaxed/relaxed;
	bh=jwFJ1YKM01Dmk1VMUDaLnYk2jOJpFExVOl5kgZ5RDj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZ5YJPXA3iD/ET+HnHVm7BEjZfPwVHjNlykxCGKwqTsg0avOCwsD8PrHN90WsiOEPKDvABQO8imYrqAJWDbRRimaACuh6FwKjrT5VWV0zPHG4movS4A+MxIngXR+R6jeTo4KOnpHcsugCfXcMO+HWBXN2Z2EtUWBUpNeE0W0zQ0GOseh9AUehdOjbLVL/CZUXcNOtsI5VEPJbuAgUFBKVoj5jF+UszMnovFIdV/wgYNeK0tjxnCjX2MpP2SYyfJb8+ShRBDfm4SsDEAuLHsO3mpDOqW/y9TDXkORIaWB9OnyW5ZogT2BVeVoj8AJb4NeCsj1OWbsnGyq9jrHoK4RpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IhruEwm7; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pyz7FTFK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IhruEwm7; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pyz7FTFK; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=pfalcato@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IhruEwm7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pyz7FTFK;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IhruEwm7;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pyz7FTFK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=pfalcato@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgqmX74Zbz2xS3
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2026 01:58:52 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6E3734D247;
	Wed, 25 Mar 2026 14:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774450730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jwFJ1YKM01Dmk1VMUDaLnYk2jOJpFExVOl5kgZ5RDj0=;
	b=IhruEwm7GYgYiYdj14/ihXFaqlkQSYC9mJzbZEysOgULoLEYc2th5nMp30ovZGWxl6scH9
	VdKlgBokFm+JYe99fBAmGMdwcFB/jXWuYdNtgJ0Kp4Q2puyNmhT7wAu5U/54EYpY7SC3QQ
	8kJnz33VQL3afgG9AY4l6hrcUQuCiEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774450730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jwFJ1YKM01Dmk1VMUDaLnYk2jOJpFExVOl5kgZ5RDj0=;
	b=pyz7FTFKDSPa38IybHttOLNkOCxY8GUGNa+tVSLpg0w3uGkk7fONUm1DgIECQNVtgiV0pG
	s838nfi0QtNQzJBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IhruEwm7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pyz7FTFK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774450730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jwFJ1YKM01Dmk1VMUDaLnYk2jOJpFExVOl5kgZ5RDj0=;
	b=IhruEwm7GYgYiYdj14/ihXFaqlkQSYC9mJzbZEysOgULoLEYc2th5nMp30ovZGWxl6scH9
	VdKlgBokFm+JYe99fBAmGMdwcFB/jXWuYdNtgJ0Kp4Q2puyNmhT7wAu5U/54EYpY7SC3QQ
	8kJnz33VQL3afgG9AY4l6hrcUQuCiEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774450730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jwFJ1YKM01Dmk1VMUDaLnYk2jOJpFExVOl5kgZ5RDj0=;
	b=pyz7FTFKDSPa38IybHttOLNkOCxY8GUGNa+tVSLpg0w3uGkk7fONUm1DgIECQNVtgiV0pG
	s838nfi0QtNQzJBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B017944466;
	Wed, 25 Mar 2026 14:58:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gDSRJyf4w2mXZwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 25 Mar 2026 14:58:47 +0000
Date: Wed, 25 Mar 2026 14:58:46 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
	Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
	Chunhai Guo <guochunhai@vivo.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Tony Luck <tony.luck@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Dave Martin <Dave.Martin@arm.com>, 
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, 
	Johannes Thumshirn <jth@kernel.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-mm@kvack.org, ntfs3@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/6] mm: reintroduce vma_desc_test() as a singular flag
 test
Message-ID: <kci3actvfoj2rc2i6znf2ff24yu5q7ewgo2byqegmhjiv7ptzy@4ppp3xt5mwq2>
References: <cover.1772704455.git.ljs@kernel.org>
 <3a65ca23defb05060333f0586428fe279a484564.1772704455.git.ljs@kernel.org>
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
In-Reply-To: <3a65ca23defb05060333f0586428fe279a484564.1772704455.git.ljs@kernel.org>
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2999-lists,linux-erofs=lfdr.de];
	FORGED_SENDER(0.00)[pfalcato@suse.de,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,arndb.de,linuxfoundation.org,intel.com,kernel.org,gmail.com,linux.alibaba.com,google.com,huawei.com,vivo.com,linux.dev,suse.de,paragon-software.com,arm.com,amd.com,wdc.com,infradead.org,suse.cz,oracle.com,suse.com,ziepe.ca,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[44];
	FORGED_RECIPIENTS(0.00)[m:ljs@kernel.org,m:akpm@linux-foundation.org,m:arnd@arndb.de,m:gregkh@linuxfoundation.org,m:dan.j.williams@intel.com,m:vishal.l.verma@intel.com,m:dave.jiang@intel.com,m:xiang@kernel.org,m:chao@kernel.org,m:zbestahu@gmail.com,m:jefflexu@linux.alibaba.com,m:dhavale@google.com,m:lihongbo22@huawei.com,m:guochunhai@vivo.com,m:muchun.song@linux.dev,m:osalvador@suse.de,m:david@kernel.org,m:almaz.alexandrovich@paragon-software.com,m:tony.luck@intel.com,m:reinette.chatre@intel.com,m:Dave.Martin@arm.com,m:james.morse@arm.com,m:babu.moger@amd.com,m:dlemoal@kernel.org,m:naohiro.aota@wdc.com,m:jth@kernel.org,m:willy@infradead.org,m:jack@suse.cz,m:Liam.Howlett@oracle.com,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:hughd@google.com,m:baolin.wang@linux.alibaba.com,m:jannh@google.com,m:jgg@ziepe.ca,m:linux-kernel@vger.kernel.org,m:nvdimm@lists.linux.dev,m:linux-cxl@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-mm@kvack.org,m:ntfs3@li
 sts.linux.dev,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfalcato@suse.de,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 56977327509
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 05, 2026 at 10:50:18AM +0000, Lorenzo Stoakes (Oracle) wrote:
> Similar to vma_flags_test(), we have previously renamed vma_desc_test() to
> vma_desc_test_any(). Now that is in place, we can reintroduce
> vma_desc_test() to explicitly check for a single VMA flag.
> 
> As with vma_flags_test(), this is useful as often flag tests are against a
> single flag, and vma_desc_test_any(flags, VMA_READ_BIT) reads oddly and
> potentially causes confusion.
> 
> As with vma_flags_test() a combination of sparse and vma_flags_t being a
> struct means that users cannot misuse this function without it getting
> flagged.
> 
> Also update the VMA tests to reflect this change.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Similarly LGTM.

-- 
Pedro

