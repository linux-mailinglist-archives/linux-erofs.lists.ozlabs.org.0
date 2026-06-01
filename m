Return-Path: <linux-erofs+bounces-3494-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KZqECiBHWpZbQkAu9opvQ
	(envelope-from <linux-erofs+bounces-3494-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 01 Jun 2026 14:55:04 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F4A61F9F6
	for <lists+linux-erofs@lfdr.de>; Mon, 01 Jun 2026 14:55:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTYp94ZDzz2xqn;
	Mon, 01 Jun 2026 22:54:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=220.197.32.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780318497;
	cv=none; b=aHvJ+WQ1lz8tmjeumK89Pjm3aN2SWDJwPgXFlI136GHyuil3ge50bPHLaRWatM+QkzVOlOHD/apCAkBv4NSOKzqEAT7W+0Q4eyNIN1sClThzONc2cSlbDJZkFcU21NikN5IdrN6+c/Iy1TwJtoqG6/c14Pqa7uzlj9V1i3/O+2LEkFm+LAxeO+KBIGoFaUSndoQ70A1QpJtn8ZHftCySFmr9XZ6JIZ5xPeSQHvG0QdZL/WF8gQ1miZp6lrByxFfIs/XBhb1MJKaxk65ajOWS0Bzv6uBOyN/omSxy0Wbqi2mRaVNzxzUvrV5MKTeTRERtSvYePwgbk/ChzSd9SjNssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780318497; c=relaxed/relaxed;
	bh=qX7hRrQgYldACeV4fHFJpS6K7f0DZAtACSNJRoAvHHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9cgonhsQrtYukoc6rDNGd4jOtYSgE0svPXkNGlF0XaZFE6TDzUazhcrwrdtXCaaOP4yA1h1Q6MQWfoR65AKuysAOYcTUcmu/rba9cf1Cjbo94mbGlOUahR9jUy44iCcWfkowq8LG4leuwurJvcpeRGxpOCtV/XVdRJO4j/uTwn9QYBfAB3qHhL6sMw/hzyo92IeXyaqz5Et2VGrMKxjExSR1fvOTzD5VnplWaVAv+aUGlAv1ICFctX+9pneDrEWV1nsSehWxiH/e10gwe1WObpmlNNW9uAj3h1KAHsbKbv74KNsDrdUTxsbC4qf92+L58CYY33JKZAUAIGO6s9UnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=yeah.net; dkim=pass (1024-bit key; unprotected) header.d=yeah.net header.i=@yeah.net header.a=rsa-sha256 header.s=s110527 header.b=krBG+p/5; dkim-atps=neutral; spf=pass (client-ip=220.197.32.19; helo=mail-m16.yeah.net; envelope-from=gxnorz@yeah.net; receiver=lists.ozlabs.org) smtp.mailfrom=yeah.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=yeah.net header.i=@yeah.net header.a=rsa-sha256 header.s=s110527 header.b=krBG+p/5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=yeah.net (client-ip=220.197.32.19; helo=mail-m16.yeah.net; envelope-from=gxnorz@yeah.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 130 seconds by postgrey-1.37 at boromir; Mon, 01 Jun 2026 22:54:52 AEST
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gTYp422tPz2xdh
	for <linux-erofs@lists.ozlabs.org>; Mon, 01 Jun 2026 22:54:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=qX
	7hRrQgYldACeV4fHFJpS6K7f0DZAtACSNJRoAvHHk=; b=krBG+p/5ZEm8hiFoZd
	go/9KaPbSt6DQQ9gnr2bUEKOV3JVLEDzUJAsduiiH61L2kck+/tDzLu6SQgBFrNu
	zdLnWsH5hp1hyA6cXLhRoIqIdHJpHdL9QvnL0DgHFvYTI+UvjRULxOV+kIHWJpsH
	AFrclxw/wyFrAsWVCNfqqqdaQ=
Received: from yeah.net (unknown [])
	by gzsmtp2 (Coremail) with UTF8SMTPA id Ms8vCgA37wiIgB1qQ3hoAQ--.31466S2;
	Mon, 01 Jun 2026 20:52:24 +0800 (CST)
From: Guo Xuenan <gxnorz@yeah.net>
To: zhaoyifan28@huawei.com
Cc: guoxuenan@huawei.com,
	linux-erofs@lists.ozlabs.org,
	zhukeqian1@huawei.com,
	Guo Xuenan <gxnorz@yeah.net>
Subject: Re: [PATCH] erofs-utils: build: link tools with liberofs dependencies
Date: Mon,  1 Jun 2026 20:52:21 +0800
Message-ID: <20260601125222.948405-1-gxnorz@yeah.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529071702.981596-1-zhaoyifan28@huawei.com>
References: <20260529071702.981596-1-zhaoyifan28@huawei.com>
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
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Ms8vCgA37wiIgB1qQ3hoAQ--.31466S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUUUUUUU
X-Originating-IP: [124.70.231.60]
X-CM-SenderInfo: pj0q023261vtnkoqv3/1tbiOAkkWmodgIloagAA3z
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[yeah.net,none];
	R_DKIM_ALLOW(-0.20)[yeah.net:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyifan28@huawei.com,m:guoxuenan@huawei.com,m:linux-erofs@lists.ozlabs.org,m:zhukeqian1@huawei.com,m:gxnorz@yeah.net,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gxnorz@yeah.net,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[yeah.net];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3494-lists,linux-erofs=lfdr.de];
	DKIM_TRACE(0.00)[yeah.net:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[gxnorz@yeah.net,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,lists.ozlabs.org,yeah.net];
	HAS_XOIP(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yeah.net:email,yeah.net:mid,yeah.net:dkim,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Queue-Id: 48F4A61F9F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It works perfectly,Thx.

Tested-by: Guo Xuenan <gxnorz@yeah.net>


