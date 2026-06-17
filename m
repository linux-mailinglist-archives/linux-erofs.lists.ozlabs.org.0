Return-Path: <linux-erofs+bounces-3660-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hdUhBV1oMmo1zgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3660-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jun 2026 11:26:53 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE15697E4A
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jun 2026 11:26:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cZT3Af0T;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3660-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3660-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggJQc3Xgbz2yfD;
	Wed, 17 Jun 2026 19:26:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781688408;
	cv=none; b=PW/EERFuuukcBDedBiFcupEGGcd0ctaPM0BwLK8+jCF3TQ/I/qF1htln9aClZoe65jiJUOMpZ9OBeuqartklXBI5pzK3Ybw/irzsEzmZK7GXK6dWk23UkpdNVxzhLyTdeN2C8dS9/V7uDYg1odRxbdpDUz6n48MVcLbgNnjjT0ViW8Po9Ra0+WNWCBS6qRaOcU0kvDCI8WIUCXGxyf8FZbKqvQfs6+A6UrzLPjUei9tSaiH3Ylf/pLUQ+fbPyYwllomf/np2F3LWV7ED4JsmismiIRgvG8v0Ss7dk1PnnUlDaAg0cl/msIXnwhIdnysurpOWKssfHxt1ZwofJm6q0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781688408; c=relaxed/relaxed;
	bh=hOhaP1OaoR+UZZSCRy5KHBEq3gQvQZdhNLr67J2uV+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6vmBtAoZoMUz0K3jOU0sY7woo+tEs1OIcimfybw479AcwTHJfWC0aQw+97z90hmQdEKzW4vBLXeL3d0NQ2Klhe2oWQ0OWxQW1rwGgkzW7wUg9lNTN5NPhHcmtCivb3/Lpak3qh2DmrrKYrf0lSwhtL1P+bxE4BLrRzy9jMHZ/4BvCmDcSF54bJn9HBGZACA4cCx+D49YLPC8cZNW84dgtcYfneTzdTV+PhCSNQoYtU0dwHScSfekWhVAGKkgMtx9e8G2bJL2/BtwEg6SGlvyDP00O91MCG8zfTZtAHRUEnqMFWa+94cUk0Ce9/7bkhDXyRzfbl9NPCCwWaXWWNV2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZT3Af0T; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggJQb4sWPz2yb9
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jun 2026 19:26:47 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1F17D43DA7;
	Wed, 17 Jun 2026 09:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2F11F000E9;
	Wed, 17 Jun 2026 09:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781688405;
	bh=hOhaP1OaoR+UZZSCRy5KHBEq3gQvQZdhNLr67J2uV+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cZT3Af0T0IWUuc1r9zI/xA0uAIXw2Y2OWW3rXg0r1QNqlwNYVnaxcq5CFm933d6vy
	 Kw2wr4iY9P+w7mar3VjaC73o/zB/yktfehj3+sX+2+pH7MwZ+1HYP1msnBdafBWbgz
	 WFgAnKA8mih+A7/RYse4sBWDk/ae34tXmA5k03hDRITxIMtzG2AvieF33hAKzYqBTd
	 ReNE7qTkwhpvwxdL6+ncAFA2XM5tPj/UP/tBGDGLIx1T3tXD1ByzQQedQnZSRXpGfv
	 k6mDTiSBPJJmVTBRl9ttrTgvVk2AWyJnzFwp4Armi3Ga3IeOR9IWZeKMmaodqvjCyU
	 lhJLdjD0o1CgA==
Date: Wed, 17 Jun 2026 11:26:39 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org, Gao Xiang <xiang@kernel.org>, 
	linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH RFC 2/8] fs: add a global device to super block hash table
Message-ID: <20260617-hoffen-eschenholz-abmarsch-fc69ce9e1640@brauner>
References: <20260602-work-super-bdev_holder_global-v1-0-bb0fd82f3861@kernel.org>
 <20260602-work-super-bdev_holder_global-v1-2-bb0fd82f3861@kernel.org>
 <20260616123443.GA21024@lst.de>
 <20260616-fragil-duktus-nachverfolgen-60f54584c206@brauner>
 <20260617062523.GA20041@lst.de>
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
In-Reply-To: <20260617062523.GA20041@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:jack@suse.cz,m:axboe@kernel.dk,m:viro@zeniv.linux.org.uk,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:cem@kernel.org,m:linux-xfs@vger.kernel.org,m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:tytso@mit.edu,m:linux-ext4@vger.kernel.org,m:xiang@kernel.org,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3660-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2AE15697E4A

> No, we don't need a secondary device number to sb mapping.  On the other
> hand we do need the deviceloss, freeze etc upcalls to work for owners
> that are not file systems like mdraid or dm, even if they have been
> slow to pick this.  The whole idea of the holder ops is to abstract
> away from who holds it instead of adding back the broken hard coding
> of the superblock.  Otherwise you're just badly reinventing get_super.

No, the expanded version works for all device numbers. There's also
no-hardcoding. And non-fs users may do whatever they want with their
holder ops ofc. erofs always had the non 1:1 relationship between
devices and filesystems and for that case it seems sane. I'm happy to
let the series sit for a bit to gather input and do the security
mediation patches first. The series are complementary.

