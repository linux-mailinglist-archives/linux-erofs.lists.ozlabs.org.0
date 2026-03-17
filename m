Return-Path: <linux-erofs+bounces-2810-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAhmHQGGuWlyIgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2810-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 17:49:05 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 195942AE75A
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 17:49:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZybK41jfz2yhV;
	Wed, 18 Mar 2026 03:49:01 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773766141;
	cv=none; b=KWHBU0w+oDO8xiGgFvRTtoThAUKE+KhADvgqjsUDavRxQ+yurL3NPd2pWMakL4TZhJCA+gTN5qxCFdiEcOtI86NMnNVnx2w6bKUR1hVxUJENutp5AujeT2C74QnsG4Z+MDJf8+lQUJ1WEP5Z+psACHJW6isfbImrCR2qIAU6WNQuOZThFVhn34W0IJZQ5bH1K26rx6YyXPhcnmXYnSEYLfc1cVPme9JkTXKgB49yd0Edbe4gf6LgiiWLCs6w3JTKNQY9AQUzxpylSimxea4iAfdM+S9UQWZdDovIoVt+PX57xgFAH8glsNnLvdnCujX/dbJR+NNtQdLJfL+q37iEnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773766141; c=relaxed/relaxed;
	bh=1Yvk9LqhxX/XToXW17+9d+gmTgV4etSxa0IvfAaAMp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xiy2J+qAqtGDjYD8B2ry0bkIRquDTt10Qwd9QxbaNK8WWTmjYV8+g4Ags0yi97Xj/7El8CRRch27e5pCKZZ33T074+V4pnWzyJxazk9sWcuQGHaxqWk6iB9uOvTBwyhv8SAB7sPBV1Jdm247ETXyqH3y5tNeKQ5wpRjGzyuoOn/inyIi5FuMk+u6WJKA+Y+P0wjyUMTFSn2tCO20Sah8LgDvQLCxHPk3/kfnYJWti8O/w4Q0DHpPQdS1kaMfUh/9CS8Znp41ZUHk06xBw5bHIISQk8ZLeXTlSSZiBeqRbOl5Kj+MW9Xg0OHFQQEBDvZtBrGQSh8HSWRcsZ3DtquiLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ClYjRaf9; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ClYjRaf9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZybJ5KKPz2yFd
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 03:49:00 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0B616429D1;
	Tue, 17 Mar 2026 16:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A40EC4CEF7;
	Tue, 17 Mar 2026 16:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773766137;
	bh=nXLfEz81Gf3gYHnAYQWj5VS95cn73nUWk/srtCPnV5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ClYjRaf9Tqp2gbPoOm3ec+iKWyWhA2GTl+nKOG5EpG7t+dopPPIrRUHHxtWchq41o
	 601+QbKX+9EuKUJacDq7N5j3wLcG3XTDc8QiGm/4hzqVJLGlmm/qcV/Ub/R2QIc/Yv
	 XMd5oaaW/Y/ts/BtJ5szxcjqccnJPPf8B7liQY0Y9jpQjU0Qex5yffM2OB1iaNZyFr
	 tv96ooSemOPojNOGFi8BtQrv+WIEPWZYh9F4zOZQjt9Q6w7JqE7hs484xH5H7yQ+ii
	 cwoX4LOeFjJ7WH0YQX1z4Y8MaWElroR8BZv9YP+7SrXL/3SwgmZBSWLL3qb9nq4IP3
	 u1HIOn6rFvWmw==
Date: Wed, 18 Mar 2026 00:48:52 +0800
From: Gao Xiang <xiang@kernel.org>
To: Utkal Singh <singhutkal015@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org, yifan.yfzhao@linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] erofs: validate h_shared_count in
 erofs_init_inode_xattrs()
Message-ID: <abmF9Nn85cz35C1k@debian>
Mail-Followup-To: Utkal Singh <singhutkal015@gmail.com>,
	linux-erofs@lists.ozlabs.org, xiang@kernel.org,
	yifan.yfzhao@linux.dev, linux-kernel@vger.kernel.org
References: <20260317152439.5738-1-singhutkal015@gmail.com>
 <20260317164135.24892-1-singhutkal015@gmail.com>
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
In-Reply-To: <20260317164135.24892-1-singhutkal015@gmail.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:singhutkal015@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:yifan.yfzhao@linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-2810-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 195942AE75A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 04:41:35PM +0000, Utkal Singh wrote:
> A crafted image can set h_shared_count to a value much larger than
> what xattr_isize allows. The loop in erofs_init_inode_xattrs() then
> reads shared xattr IDs far beyond the inode's xattr region, causing
> an out-of-bounds metadata read.
> 
> Add a sanity check ensuring:
> 
>   h_shared_count <= (xattr_isize - sizeof(erofs_xattr_ibody_header)) / 4
> 
> Return -EFSCORRUPTED when the check fails.
> 
> Signed-off-by: Utkal Singh <singhutkal015@gmail.com>

What happens with your v3?

What happens with the commit message and the division?

Could you explain what happened?

Thanks,
Gao Xiang

