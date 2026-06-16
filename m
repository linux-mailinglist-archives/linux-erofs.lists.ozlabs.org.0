Return-Path: <linux-erofs+bounces-3653-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pNSECvhkMWrGiQUAu9opvQ
	(envelope-from <linux-erofs+bounces-3653-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 17:00:08 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E15690B7B
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jun 2026 17:00:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jA2q0c4E;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3653-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3653-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfqsZ1Kszz3c3l;
	Wed, 17 Jun 2026 01:00:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781622002;
	cv=none; b=N1VYT2M6hKpN+oV+pRtRAgPxGs0T3SJEmaLYcCLVZbZ/iggJtzgHL8zAusMYfhGSo5rZwhHLn+0k2LxRaQ77ePebyc4O7X68XfD0hj9OcldRG/Cac572FDxzVQosHoPMMoQFEY1y54Ad/Ag8XV30nTI9cd6uf7VxL9hNTuDHlOy2YH/0e7jV7Or3Ip1kwfa8+bg+r1GP3S7r3G/IePQl6zDMbD6/H7W3io6cAMA+u4HQ4FMS3zhfw9ygR+guvW32xkobuifAAEPQyRjePjHekcgEC2RR0Hrr0Lfm+LBXjwYQmQoPZXfnO3UoTGfPRY4u+5u3Y8DNBgOA0eMTkoY1hA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781622002; c=relaxed/relaxed;
	bh=54nrZd56QlDOLjrnGUMxikC0RJz3adz3i0y4la/F30Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjHsdIfDnE2mfyeWl8Vinc34JsVAG6KeDh1DEUcOQP7djBQmBEEDR3lRt1c2J+THFbJc8ytwcuwo0K+FEf6WjSOCRXo/Dx537U33OPcetrj9TeKJgA92pKCBgoymv+I/IKHU9NMQi7Zvh0s2ZOX4MCz43qknxFcHdL8rImkfnbwXdNB+/vNhlkuaVEjSa5bWaMEeK7gJUljIzVEDZquZQf4x5NW0wpi7sYo2HO95Cl0FZjPDzahMLZ7i/RFqxkhmwMzQyRMkCsTvu75lZ2pPzeAfEen6AvOHEQAwDGx9NJ7JlG7GAMbmV5wC6EkMeH5gIazZuq+dCMh9oNnW/Xwnuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jA2q0c4E; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfqsY11nZz3c2L
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jun 2026 01:00:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CC09F432CE;
	Tue, 16 Jun 2026 14:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5AC1F000E9;
	Tue, 16 Jun 2026 14:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781621998;
	bh=54nrZd56QlDOLjrnGUMxikC0RJz3adz3i0y4la/F30Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jA2q0c4Ee6LVq3wsrXzEp9N7Su9CbMmoI6RP4rBSzy7r8wEReuDOvyko1gR0PEBZq
	 bg9x1Q83U6bfJVi8MI1KRXQHZSlLKfTldHay7P4JnrGnDygtoE8Uyr1SZXXq6iopy+
	 1uiksflRJgCiH46ewjX97OHYoJUczZNbraNTb5w472Yzug6sY9EulbLUSfhDKPqy2P
	 fXQQ0U37sAQtSAUQVyf1H6jtse9vqf7bUdWGz5uvC+yB+YxD4JAWUp9yh5ga+TP8bC
	 P3YC8LvGv2tE0gC7aIeruXedVTLx5LPurEO7KW1M1oaYJSRkYmGAKiLdMI2ZflI/gv
	 Ek4hr9EandhYQ==
Date: Tue, 16 Jun 2026 16:59:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org, Gao Xiang <xiang@kernel.org>, 
	linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH RFC 2/8] fs: add a global device to super block hash table
Message-ID: <20260616-fragil-duktus-nachverfolgen-60f54584c206@brauner>
References: <20260602-work-super-bdev_holder_global-v1-0-bb0fd82f3861@kernel.org>
 <20260602-work-super-bdev_holder_global-v1-2-bb0fd82f3861@kernel.org>
 <20260616123443.GA21024@lst.de>
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
In-Reply-To: <20260616123443.GA21024@lst.de>
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.30 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3653-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:jack@suse.cz,m:axboe@kernel.dk,m:viro@zeniv.linux.org.uk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:tytso@mit.edu,m:linux-ext4@vger.kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brauner:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92E15690B7B

On Tue, Jun 16, 2026 at 02:34:43PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 02, 2026 at 12:10:08PM +0200, Christian Brauner wrote:
> > fs_holder_ops recovers the owning superblock from bdev->bd_holder, which
> > forces the holder to be exactly one superblock and prevents several
> > superblocks from sharing one block device. That's what erofs is doing.
> > 
> > Introduce a global dev_t-keyed rhltable mapping each block device to the
> > superblock(s) using it. The holder argument becomes purely the block
> > layer's exclusivity token (a superblock, or a file_system_type for
> > shared devices) and is no longer needed by the fs specific callbacks.
> 
> Err, no.  block devices need to have a specific owner.  If erofs wants
> to share a device between superblock it needs to come up with an entity
> that owns the block devices which is not a superblock.

It already did.

> IMHO sharing devices between superblocks is a bad idea, but that ship
> has sailed, but please keep it contained inside of erofs.

We need a simple device number to superblock mapping anyway and that can
simply be centralized in the vfs. And it can work with anon device
numbers and block device numbers uniformly.

