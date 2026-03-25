Return-Path: <linux-erofs+bounces-2993-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBDUKm/2w2lZvAQAu9opvQ
	(envelope-from <linux-erofs+bounces-2993-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 15:51:27 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D86D8327266
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 15:51:25 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgqbt479hz2xcB;
	Thu, 26 Mar 2026 01:51:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774450282;
	cv=none; b=NkZZp5PVlfDyZH6tXnaIJLeGVXv4s/YZXrqbStlp8EzIXKbqzkiq8P+DkRrtVVtWKGZ7cp9gvgKC4ygELGgJQ/d7jGV7p2E5HzBUImrG30GdckUh6mEfcEhIki1E6ZSk0VA1TkWpKt1cAxQWndnxPByxoI1NaIF7/0xvkaC1SuiTr/0QiRhz8OppVEcxb4Uic0L8EiTwPxXw5WKL2rmHA3dHUSsu9GsDGY5Guiu4HfGI8HAoUoiN9kM+ulaAcazb8nmTYnesPX5gjB/Z9ELHvQAbJO0/UwPLfTiC+N2fN1CMT6CjPvVNhl4fAZuVOKzFvIm8cFt9Mt/IP9H0y9i+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774450282; c=relaxed/relaxed;
	bh=/IbrNguOL2oU7ugpbxDymPY+bcfAOeIY2ch0aNWgxbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Op8dDAmk0YePnLmqdO01D8CRtwn63b3qXgYmRzw9Oui5qbCcn4ZARmaPq0c3oa8L6Iu2lPWzLZZstIlxtz1wwk9lRXplm5Tfu/yB6jH6tmIdHIDx1+nVoMEomv+1FQ42geNeFrlv7Q/xDvi966oaxVNJaGYPhxNBBUg0Go8sM10Bx5Q02oOsBOx59M9kk9ccUrDG9zeOrgOm8x1T7pLSyzc6MdcN0MouU3JrjB4pIbrQZcRKwSowjaT8Np7o9fCY3eHn5EgfEnBO3YZFgzs0RakDN9K1GJgOVU9yP/9wL0n36h9VPlapSMJaY3pmoEDPVlnquYGXxxDQurQMoadGSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=HWmOZ5Fg; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=u14cIhOK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=HWmOZ5Fg; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=u14cIhOK; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=pfalcato@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=HWmOZ5Fg;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=u14cIhOK;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=HWmOZ5Fg;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=u14cIhOK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=pfalcato@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgqbr6SSjz2xS3
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2026 01:51:20 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 63F235BD52;
	Wed, 25 Mar 2026 14:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774450269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/IbrNguOL2oU7ugpbxDymPY+bcfAOeIY2ch0aNWgxbs=;
	b=HWmOZ5FgwDtrteSM2Ew5PXqlKiEfNmaAxZwNcrDu5cm7qqyNqx+T4KuS+fzLrhGhLe0BMw
	4jK5lnRLUqHsAlBFQz+I+hBfsPpC3uQ9V4D0BKTscU6LcEG3GYwivCMcvxhC1hemevb4sH
	uOKbUkmNtRHNhlJlq6nBbg/lY2lzSfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774450269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/IbrNguOL2oU7ugpbxDymPY+bcfAOeIY2ch0aNWgxbs=;
	b=u14cIhOKRc22D/k23HZ0bIZUBPARER5TAWoWA++mI3iuA8hY3F7HH/iLi3+LZe1XvB+eno
	2GHcX4DZFxOCZCDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774450269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/IbrNguOL2oU7ugpbxDymPY+bcfAOeIY2ch0aNWgxbs=;
	b=HWmOZ5FgwDtrteSM2Ew5PXqlKiEfNmaAxZwNcrDu5cm7qqyNqx+T4KuS+fzLrhGhLe0BMw
	4jK5lnRLUqHsAlBFQz+I+hBfsPpC3uQ9V4D0BKTscU6LcEG3GYwivCMcvxhC1hemevb4sH
	uOKbUkmNtRHNhlJlq6nBbg/lY2lzSfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774450269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/IbrNguOL2oU7ugpbxDymPY+bcfAOeIY2ch0aNWgxbs=;
	b=u14cIhOKRc22D/k23HZ0bIZUBPARER5TAWoWA++mI3iuA8hY3F7HH/iLi3+LZe1XvB+eno
	2GHcX4DZFxOCZCDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7C9A4445E;
	Wed, 25 Mar 2026 14:51:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zMJkKVr2w2nWXgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 25 Mar 2026 14:51:06 +0000
Date: Wed, 25 Mar 2026 14:51:04 +0000
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
Subject: Re: [PATCH 1/6] mm: rename VMA flag helpers to be more readable
Message-ID: <6c6le67q23xsity3tkfq2uazzhwustmqcsqj3talft6qq737hz@dytog6bi4vsa>
References: <cover.1772704455.git.ljs@kernel.org>
 <0f9cb3c511c478344fac0b3b3b0300bb95be95e9.1772704455.git.ljs@kernel.org>
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
In-Reply-To: <0f9cb3c511c478344fac0b3b3b0300bb95be95e9.1772704455.git.ljs@kernel.org>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2993-lists,linux-erofs=lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: D86D8327266
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 05, 2026 at 10:50:14AM +0000, Lorenzo Stoakes (Oracle) wrote:
> On reflection, it's confusing to have vma_flags_test() and
> vma_desc_test_flags() test whether any comma-separated VMA flag bit is set,
> while also having vma_flags_test_all() and vma_test_all_flags() separately
> test whether all flags are set.
> 
> Firstly, rename vma_flags_test() to vma_flags_test_any() to eliminate this
> confusion.

Hmm. The names are getting longer. We should fix this One Day.

> 
> Secondly, since the VMA descriptor flag functions are becoming rather
> cumbersome, prefer vma_desc_test*() to vma_desc_test_flags*(), and also
> rename vma_desc_test_flags() to vma_desc_test_any().

> 
> Finally, rename vma_test_all_flags() to vma_test_all() to keep the
> VMA-specific helper consistent with the VMA descriptor naming convention
> and to help avoid confusion vs. vma_flags_test_all().
> 
> While we're here, also update whitespace to be consistent in helper
> functions.

Extremely amazing patch! you were truly inspired!


> Suggested-by: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro

