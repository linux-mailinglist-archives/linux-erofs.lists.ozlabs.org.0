Return-Path: <linux-erofs+bounces-2843-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sARJEZvNu2mXogIAu9opvQ
	(envelope-from <linux-erofs+bounces-2843-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 11:19:07 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 507832C95B6
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 11:19:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc1rR73vXz2ykV;
	Thu, 19 Mar 2026 21:19:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773915543;
	cv=none; b=DPGp3Ce6dpKvAcK6uPzSmswc5UYBWQfNuiI1zl5EQAjki4QSZJ3y0aCxm0QH9R66EBA6WpincyY4eiseBr9odFIBc0VWDYkwzTJPQNwMyI8xv3SZCC6zD+D1bQ4ZFVrFKZTvlX9UAPoCy7mRcy+3WUkHfT9O8ufN9/Z588pKK/eyzH6+K4nVytES+O1hpADvJL58dB8vExzPpI9V5dTsMQeWf4moda/kCcwo++ZrJibaUUcVB3cRFL/OeURSPxTQvOzXRWkZdAbfgYzE/AsiqWKQhPQRuYpIlbpiQWf4vBiM8IJHtA35reKwSBGPFAtdirBhxJRaYzBR/tvQGwOVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773915543; c=relaxed/relaxed;
	bh=BlW8MzDdqjOuXUNvwFbPWBwQIcaiEctArAJ/zeIEZTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hxlrvXMtGBae9NOKiuIe8QenzB6lTUiU3dtpKPn8ktSFcWNuLHDWu7LwlkG26ssIg8wUnkNyan8ITroyo7QOu1QZIhwXY0pEOZb6f0TDoP8+29iPPeIySyK8lCMku3d9ZzNBgvdqs8GoQIbedCBnizmeVoIUlWWo0Yx+mLbQ0Wb2pQtWXsSYB4pugpt4N39+pwgeuSFP5sMmp+OLUUQZe144jf9ajdQuiw1M2jtMH6/m4gePhpY9jF9laci9H+MI0kaibGNMywY+tRPlaS6vzdMluu3xTDURHr5gYQtnGecO6uZ1V4SSdAm4LmxQ0RNfKqmTMqZm3GJcuEkhqIO2xA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sDqXiUg2; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sDqXiUg2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc1rP56MMz2ygT
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 21:19:00 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773915535; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BlW8MzDdqjOuXUNvwFbPWBwQIcaiEctArAJ/zeIEZTg=;
	b=sDqXiUg2zsem6G6EZs1vzVQN5qa4zb1dlU0jln+Vur1XLc5/b5qorvGl8HSP65Fg2GuAa6N0dmC/7dQ718jPmMkGin+X2yTMOR4f8iQqxUjmoqIsJv4unwe+DjuOLiwGOO7wm3gssit2nxYFIMv3uvYsugcofq8NAXKmvCJ5lsc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X.I5jMp_1773915533;
Received: from 30.170.14.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X.I5jMp_1773915533 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Mar 2026 18:18:54 +0800
Message-ID: <c5229fc2-1897-49ae-8d05-acf28670cac8@linux.alibaba.com>
Date: Thu, 19 Mar 2026 18:18:53 +0800
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
Subject: Re: [PATCH] erofs-utils: lib: return error on ZSTD decompression
 length mismatch
To: Utkal Singh <singhutkal015@gmail.com>, linux-erofs@lists.ozlabs.org
References: <20260319101721.17105-1-singhutkal015@gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260319101721.17105-1-singhutkal015@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
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
	FORGED_RECIPIENTS(0.00)[m:singhutkal015@gmail.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2843-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: 507832C95B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/19 18:17, Utkal Singh wrote:
> When ZSTD_decompress() returns a size different from the expected
> decoded size, the current code logs an error and jumps to cleanup
> without setting ret to a negative value.
> 
> Since ret still holds a positive byte count, the caller interprets
> it as success, potentially treating incorrectly decompressed data
> as valid output.
> 
> Set ret to -EIO before jumping to cleanup, consistent with the
> existing ZSTD_isError() handling above.
> 
> Signed-off-by: Utkal Singh <singhutkal015@gmail.com>

Please stop resending the patch without any modification.

