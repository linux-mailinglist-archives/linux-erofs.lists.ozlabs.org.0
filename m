Return-Path: <linux-erofs+bounces-2206-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB6mCrsSc2lksAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2206-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jan 2026 07:18:35 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AAB70CF5
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Jan 2026 07:18:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dy76H2Zp2z2xHt;
	Fri, 23 Jan 2026 17:18:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769149111;
	cv=none; b=bCIgGUwpzN+zCawkqICXSNjiG7XzlV85lZR2EvHi+idlIjG7kZRU9C0QD5h1txCcH5V3Bd1gxsy55j8uRpBxmVMEdDnCofb6/JVbyru1GK5AXZJb6Uv0M6cOYm80P1ib4bC6jGvHV7nkUY9z6dTIv4GClSJnP2H51RSh/adgAbavSTQ7H1qY1pAHtXI1wF+Ucxrv9/uJl4FELUWyp93+DJS+EtMyawjfk/w+s9OaBBrfjoO8mjOe0/tw7SI1MEXA/QSsKpxUilRzQmR8dMQAvWig54VmZmeaplHrsC15wvkZtV8yrmi7d2SLrxgiMJaqUP1I/g7yRYWViDrHHkRGfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769149111; c=relaxed/relaxed;
	bh=9J8KKlSmceMvKAImE31glTIRJCJ62DycG997UrUSd7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgXDKy68xuam9kruTY6HET0xbBDNU6Xv2w/uN0V8Fx7TFmk/U2yQLtWDkaI1Ox8IKhmiQrDnEoUARbt8fwO7QwdQLQ/kWQ3BB/SykUKhfVd4RsloebW13vRS3TQZwctGlxLoguULoKMPlaB3X71QX4Ku5S44EPfqLVVe1rsDpbJYrdJtqQKo6F2JGA4M3jd4bXhYoDAq2niFsZ5yy4fggtDNpZ3haDiOb6Ez28+VoippNF2epvkI+MxrYzQR25Y3sd5MTd+sCsWXMpg6CodMC3QPA0mMpV49NItDAR5hmUPzucTk5T/E9DpE6/urKa4XZcELxAHWA9lodikkILB3Xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lst.de (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dy76G2RMtz2x9M
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Jan 2026 17:18:30 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id C802F227AAE; Fri, 23 Jan 2026 07:18:25 +0100 (CET)
Date: Fri, 23 Jan 2026 07:18:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Hongbo Li <lihongbo22@huawei.com>, chao@kernel.org, brauner@kernel.org,
	hch@lst.de, djwong@kernel.org, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 04/10] erofs: add erofs_inode_set_aops helper to
 set the aops.
Message-ID: <20260123061825.GA25722@lst.de>
References: <20260122133718.658056-1-lihongbo22@huawei.com> <20260122133718.658056-5-lihongbo22@huawei.com> <b20b263d-132b-464e-8314-d3f795e5e582@linux.alibaba.com>
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
In-Reply-To: <b20b263d-132b-464e-8314-d3f795e5e582@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.40 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-2206-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:lihongbo22@huawei.com,m:chao@kernel.org,m:brauner@kernel.org,m:hch@lst.de,m:djwong@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hch@lst.de,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[huawei.com,kernel.org,lst.de,gmail.com,vger.kernel.org,lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	NEURAL_HAM(-0.00)[-0.080];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: D1AAB70CF5
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 09:54:15PM +0800, Gao Xiang wrote:
>> @@ -455,6 +455,29 @@ static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
>>   	return NULL;
>>   }
>>   +static inline int erofs_inode_set_aops(struct inode *inode,
>> +				       struct inode *realinode, bool no_fscache)
>> +{
>> +	if (erofs_inode_is_data_compressed(EROFS_I(realinode)->datalayout)) {
>> +		if (!IS_ENABLED(CONFIG_EROFS_FS_ZIP))
>> +			return -EOPNOTSUPP;
>> +		DO_ONCE_LITE_IF(realinode->i_blkbits != PAGE_SHIFT,
>> +			  erofs_info, realinode->i_sb,
>> +			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
>> +		inode->i_mapping->a_ops = &z_erofs_aops;
>
> Is that available if CONFIG_EROFS_FS_ZIP is undefined?

z_erofs_aops is declared unconditionally, and the IS_ENABLED above
ensures the compiler will never generate a reference to it.

So this is fine, and a very usualy trick to make the code more
readable.


