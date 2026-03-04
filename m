Return-Path: <linux-erofs+bounces-2498-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKw1EO3CqGkIxAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2498-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 00:40:29 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF0E20901D
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 00:40:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fR8L12wPmz30FF;
	Thu, 05 Mar 2026 10:40:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772667625;
	cv=none; b=VXKkEI351GVe50rZYBwisUhTlm+Frmlw7COlOExk9IxUTdyjYPYwxNBL3TJ4MlQApBywwNBZoSwxtbWsBEVQjFcMnLE+Dbyh04mV81IPfnfsaxvTFzMhwhy5G16OrAEOX1l46NCRlnWAXvUj4cnhWcOx00yd0LbjSo+YB2CxN1EPMxI4H3WLz1GDMtJqfAk37UEC9VTJei9opyyWetSl8VO4Y7zYlUBvrTTbNxYhabaGVzuYelPKmJSfyKAvpjOT/IxE3hS5xYL4u1zNxKBwOcdMXDyvgmq1gS9CwvZ6NofsQbW59Rcgk095kxE2lKdv1k9CkcFb4KJr2G97ccN82g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772667625; c=relaxed/relaxed;
	bh=YbRq4Ni8LNRWBMlbQIwvZJiX3/hACkXSaHWn0BLWCiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PCIuZvXdS99gGSRy8uHGESR7DauxWE4zSaJNSoW7KbNbtyWY+9vX2SlfJ1/DnS0PRzyww4NhoR6gn+nu+ckMnh9kBU8JNNH+ZI20j/MtajMdcFU8pV4PgDWyZH3J25FYZ1JcWDxh/2D+PuWlZMplM1e3grhUHsrcCJz1KGaAtdVe+x2GP/1fercGf9Wc4jvNj9BuU8fJjcvs/fl6nGfhuax+ufRCA8haecJ0Yi3FtoRGibqFS29ScE1t1LsvmUYiTx+PVaqZFOkuYP+hqFuEuYjYpfuOZ0E7lbhEaS2HUyAhMIDMZJ/r0H8IcdDv60aqeIIhRnaZNjwWz5WNSTxduQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vfY7E+md; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vfY7E+md;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fR8Kz1hW5z2xR4
	for <linux-erofs@lists.ozlabs.org>; Thu, 05 Mar 2026 10:40:21 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772667616; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YbRq4Ni8LNRWBMlbQIwvZJiX3/hACkXSaHWn0BLWCiI=;
	b=vfY7E+mdtF/4B1ER2f1AGwa8jCsY4WPzmmmHDNGySFoNSg3q6U2QzDAgR4Vra4kKcrrQHVAOYXlqJLjKwws04JGS60GekmVWSvii3VPfxPX4K+Fna/0eNLHy7ZMs0rhww+LR0b1uqSSm/75rZ+NLP5ffJYiDjhDmsBz0mu/T/jQ=
Received: from 30.170.14.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X-GJJDY_1772667613 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Mar 2026 07:40:14 +0800
Message-ID: <b72aae71-fec9-4998-a5bd-ca5cc030b9a5@linux.alibaba.com>
Date: Thu, 5 Mar 2026 07:40:13 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests: add basic smoke/integration test script
To: Aayushmaan Chakraborty <aayushmaan.chakraborty@gmail.com>,
 linux-erofs@lists.ozlabs.org
References: <CABCXVcmmXnEw6256sJsfGuG7eqLA0ytR-sJharrOHx+Yc2bLxA@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CABCXVcmmXnEw6256sJsfGuG7eqLA0ytR-sJharrOHx+Yc2bLxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 0CF0E20901D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:aayushmaan.chakraborty@gmail.com,m:linux-erofs@lists.ozlabs.org,m:aayushmaanchakraborty@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2498-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action



On 2026/3/5 02:13, Aayushmaan Chakraborty wrote:
> Hi Gao Xiang and linux-erofs team,
> 
> The repository currently lacks any automated smoke or integration tests.
No, automated integration tests are in another repo, we don't
need anything here:
https://github.com/erofs/erofsnightly

