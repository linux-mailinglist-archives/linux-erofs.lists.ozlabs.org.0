Return-Path: <linux-erofs+bounces-2304-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id h5IkL4YsjWnxzgAAu9opvQ
	(envelope-from <linux-erofs+bounces-2304-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Feb 2026 02:27:34 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D2F128F52
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Feb 2026 02:27:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fBHjH4P8Vz2xcB;
	Thu, 12 Feb 2026 12:27:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770859651;
	cv=none; b=oxhEQwgQzMxbpItucrA5ECbGBPNEZJUFag70BaR6KpvcwVqF1ohb0CZ6I6oZwtoLPuYMrH4ZHb7xYkzhnwxt5muQnSXIPZRkGhBsxbW5c01N4kt7o2mhbErsozhI9a55fjZj7wtQ7mPPs24F3Le7iqg4HF7BNUnlRMcoqoxHfP3/MxWy1129f3NXNEXd9K+RLnZrXoTEVnAWoJLXrx//stRlDeCJQ1llW9rZ0KrzrRzTKHA0x1OcRWd96aUzp8FcK3HWO5106BoBrZYOfOzJtdO5OtAoANyqrXo0Jf+nqPmuNAz4BPgwF9+6bLACd8VtGOVcGqn7az6tPAAtqmutXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770859651; c=relaxed/relaxed;
	bh=ZMwHaMfU3uQVjdoX/GRi9pusohwQs2sA+igHxUoWqT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QP47XldgBC/tgzxG/CEKPgI876CGDnTegeSO6rq98LWi4RwpAZd7H8qAcQzOplK/Nmblm091kZdh78yj2Smlu7ZU02INxEIlG0lyM4uqTU2ri070f2eYXolGK/xy1+2HW0DEYZzi/kHvxklG+ypoYCpzPRuQ4dJjc4ifdGeVHr1oTBaDwIUS+sVBqLgWhOSL336V8qD5qKs6eI3Pot/CvUfw/dMHRmxycniB/cl2mZxQZNZRPNhuQJQYHRx8utgvMnV60czqde82lkAyl1Ux42L4b72LojYF4l9nRhsrU8Hmr9mX3Cl4w/lv/x88oRxME1pEqGkVvJy0nl5ad0NWvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=S14D8gQk; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=S14D8gQk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fBHjH0VSYz2xHX
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Feb 2026 12:27:31 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B38BB60051;
	Thu, 12 Feb 2026 01:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8515C16AAE;
	Thu, 12 Feb 2026 01:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770859648;
	bh=B/VqF3pMNXT7AgKcPsCRdPF9bN6sVO/jWPDylW9RCP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S14D8gQkNN/gkSKPAKqE/vU2m/RzkkkdfJxD8hgePg3NSPGwxA22rIaftSU47oin5
	 56z8ik20eHhfnvwo2LKX9rQL92e0hrexujWDlHbrQrYnscu1APifm3WdoChl9Wu/nN
	 CIS/IpTiCHw6ups1C1fKngkGYxQ0/qxdMfzwDHZjmgEKliIIVrfllbw17qcZP3aSq6
	 Iz4mb8/JJUqzWQEv/+Ax2vzsO/pC9axmNDkeK6Ysm573N3DYse4r1Vdzq1gjsI+egI
	 YDsA6Ug8Y85NP2cA+zkopVgAuTxr7P5yOLfYST9UziPw9dD64bX+otWBJTn8VYNhv4
	 IVuwVQ7UBnRxw==
Date: Thu, 12 Feb 2026 09:27:23 +0800
From: Gao Xiang <xiang@kernel.org>
To: ChengyuZhu6 <hudson@cyzhu.com>
Cc: linux-erofs@lists.ozlabs.org, hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
Subject: Re: [PATCH v2] erofs-utils: lib: oci: support reading credentials
 from docker config
Message-ID: <aY0se7OziwKD2qtJ@debian>
Mail-Followup-To: ChengyuZhu6 <hudson@cyzhu.com>,
	linux-erofs@lists.ozlabs.org, hsiangkao@linux.alibaba.com,
	Chengyu Zhu <hudsonzhu@tencent.com>
References: <20260209075355.16969-1-hudson@cyzhu.com>
 <20260210093726.86026-1-hudson@cyzhu.com>
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
In-Reply-To: <20260210093726.86026-1-hudson@cyzhu.com>
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2304-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hudson@cyzhu.com,m:linux-erofs@lists.ozlabs.org,m:hsiangkao@linux.alibaba.com,m:hudsonzhu@tencent.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiang@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: D5D2F128F52
X-Rspamd-Action: no action

Hi Chengyu,

On Tue, Feb 10, 2026 at 05:37:26PM +0800, ChengyuZhu6 wrote:
> From: Chengyu Zhu <hudsonzhu@tencent.com>
> 
> This patch adds support for reading authentication credentials from
> Docker's `config.json` (typically in `~/.docker/config.json` or via
> `DOCKER_CONFIG`).
> 
> If no username/password is provided via command-line arguments, the
> implementation will attempt to look up the registry in the docker config
> file and use the stored credentials if found.
> 
> Signed-off-by: Chengyu Zhu <hudsonzhu@tencent.com>

I cannot apply this patch, which commit is this commit based on?

Could you try to base on the latest -experimental or -dev commit?

Thanks,
Gao Xiang

