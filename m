Return-Path: <linux-erofs+bounces-3382-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBe9MvKc/WmwgQAAu9opvQ
	(envelope-from <linux-erofs+bounces-3382-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 08 May 2026 10:21:06 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F994F3A02
	for <lists+linux-erofs@lfdr.de>; Fri, 08 May 2026 10:21:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBhs93Yd1z2xdb;
	Fri, 08 May 2026 18:21:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778228461;
	cv=none; b=T50lRgdJXn22M6l5FJ1gRPCFnZ4Y4Jmx77YkasyfKygi7iVa4qfi0esZQCh06LcYQ93C87w2AMprL3E2L1YsQOAxQfoiDQIvmltqurISXnP3q49DK1nD529dZ0VWrJGzAJV31HIKLqxo9Ye7bHQS2sDrUhf8zAgadPBk5+2+RUxxpTumwXxhKWaybj48qS8pRzZQsBH9uiqCBjRfETLr2zzE+HAgYOFaS877Vcge792Y/KgbNpDK9DBxv/V/6XsAmNo7Fx0dL4cUIYX11sV50guXljNPMwL4UL5qdQbXgQoJ6PD9Eob7Aa6/jiVpcf2BBY5wTD8iqLaAQqzdomt8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778228461; c=relaxed/relaxed;
	bh=Zkisq+nZ9+CHwylgMN2ygPINVVeeO6D8/0fnAwpndjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmZYAaCEq3lm6pOXV//yX9opzXlk5p3npImT5VjvQMwWYRxANxXp4MqGdUkEZR087njCMG3HD0CLkKSY7FA7mEaFf0VHyhU76+kfetqWrDkhb8Yuj7jdOxmeyzJ3hUYb/pYpI/+hmuFRi5oeGs0D/6Q6+C6N4BqhLu1Nck/pEcM7Vz+meocr6n5VwtibYx/jhxEWGtSaMfyRKbNNfoOMCM/tFnGFhgx8HuLAwEefwrIjDdEq3JjYTaQziTqsETsjMB1436HGSWFMNWY6cnGlK+MGL7ueU5i4hq4TWLnfYt5ljS5djMLHWMD3TuBq0LR4BM7LQ7XmTA5GL069S0b+8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=I/5Nm4wV; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+b3031b5f6a3880ed22fb+8293+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=I/5Nm4wV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+b3031b5f6a3880ed22fb+8293+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBhs34Pmcz2x9N
	for <linux-erofs@lists.ozlabs.org>; Fri, 08 May 2026 18:20:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Zkisq+nZ9+CHwylgMN2ygPINVVeeO6D8/0fnAwpndjo=; b=I/5Nm4wV3PRDZP/D/AqkSSGw4N
	EsW/0ty3dksH3teSQv6mp0d+2EwhighKdvq6fZINzN6bLB7Kp+jhtDosteYgpT1SGjMFrricSHpSn
	CaUnJuuxhkVmGf4ExRjvfHuqNmMujXvbgOUbugoaZvx9WDJyDsEBJneCYi+59El79kA/K+tgL88t7
	frB7P6NA4FHnqGu79MSXjDK+YzuficgPUzCAt/YuyLWLE5M6DGxWZGIt4kQdO/E004Yz4qCs828GB
	KijyWHAPeuFNrETJhuKbzcCvk9HwnI1iHBQhJuQ4K3w5ykRNBLVymd2DemjKnG33++WlqZk/o9CDK
	0pAaC0VA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLGS1-00000005ylP-3jcF;
	Fri, 08 May 2026 08:20:49 +0000
Date: Fri, 8 May 2026 01:20:49 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, oliver.yang@linux.alibaba.com,
	Carlos Llamas <cmllamas@google.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Tatsuyuki Ishi <ishitatsuyuki@google.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] erofs: use the opener's credential when verifing
 metadata accesses
Message-ID: <af2c4X1YCB7NEb8p@infradead.org>
References: <20260505155615.2719500-1-hsiangkao@linux.alibaba.com>
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
In-Reply-To: <20260505155615.2719500-1-hsiangkao@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 04F994F3A02
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3382-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:chao@kernel.org,m:linux-kernel@vger.kernel.org,m:oliver.yang@linux.alibaba.com,m:cmllamas@google.com,m:dhavale@google.com,m:ishitatsuyuki@google.com,m:brauner@kernel.org,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hch@infradead.org,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Action: no action

On Tue, May 05, 2026 at 11:56:15PM +0800, Gao Xiang wrote:
> Similar to commit 905eeb2b7c33 ("erofs: impersonate the opener's
> credentials when accessing backing file"), rw_verify_area() needs
> the same too.

Two things here:

 - rw_verify_area is a helper for use inside the VFS and file system
   read/write method implementation.  Erofs as a user of the VFS should
   not use it at all.
 - using the opener credentials when accessing the backing file seems
   wrong.  The entity accessing it is the file system, so it should
   have system or mounter credentials, not that of someone causing
   metadata / fs data access.  And this applies to all access by
   a file system backed by a backing file.


