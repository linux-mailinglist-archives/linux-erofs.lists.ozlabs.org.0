Return-Path: <linux-erofs+bounces-2188-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB9DDmpScmnpfAAAu9opvQ
	(envelope-from <linux-erofs+bounces-2188-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 17:38:02 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED896A187
	for <lists+linux-erofs@lfdr.de>; Thu, 22 Jan 2026 17:38:01 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxmvV6XlVz2yFm;
	Fri, 23 Jan 2026 03:37:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769099878;
	cv=none; b=OwDcP7oATX/Y/APQpQl7ZrTWjGGvwZzVri6jyD8f0ksSgWkzatBhWLsrwCctfbnEFth7WCID4NQ5RrTPYnUUj4no5/R0IIIATX7XA7QIRILs8+ROxtzzatgVjlh1hiEgPN1C02zPTnq5GzX44ArHZvhk5rS2P/xqiTat7nMArbI8jdXl8rtL4RzzuOfboyqTr7jIr0HkxH2KoKZF0qUvI5Zgk4LaQGf2t+EleQlsLtfl6VaIS+H1MDijVVmtE+4TVkto+wdGOLThJSgCD6/41gEJf3dD0v4WM1tk79gtFgfRq2mMYvwp8juwG36+AqAlaj1rmVV9nXH8JiCMIbBMWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769099878; c=relaxed/relaxed;
	bh=Lwld6vAnJB2NFeizg3t/vAsO9VfqN5FwLF5cCvhERHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgA2PbjK0XTo7cJsQnANd2I6RU/M5zHw3S8vVthwXpMTLZrcnuaPqRuAie+NudsgOeYOk74UnlxpOHYc7UTnajxDLRv6OIN9P67Jy0VgrNYuKsIb8RDmHeF9GSWN0dGM3iBvTp6nEh7XP/zrbPJjaAMcYbY31wOgwcJ6YxtGejEEopv5Twdf7WCSh9R+tifLqdPhszJNWyw4K/S1HPs1auWih45/Lu5yGIo+XDl0uYhiT/fQts8jxsUB+EoD8pI82VwSu+TRr0EC02WkvGYtGQTOfZ5fY7XL2KCcwRd8BxOqD7MqPW9uNm0E8iXDcQp1wGml4etNXCR0OgkrvYQlaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qILSA5H8; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qILSA5H8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxmvT44mVz2xl0
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Jan 2026 03:37:56 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769099870; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Lwld6vAnJB2NFeizg3t/vAsO9VfqN5FwLF5cCvhERHo=;
	b=qILSA5H8zNAYVQ94dKL821X8jG6gwrWSPGW7nmiAdq7LjPVaL6/tqDWeXyeH1J24yVocMHPUThI2SSb6pLIQTKd4xJsSzbsNAEKoT9AVpz0uKvfCsdQoIpfmzcFcO8/yXG8GJbiLPTuIiDw3ELiIvpLj8qbqK3ExXh9x9R57bqI=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wxcwr5W_1769099868 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 00:37:49 +0800
Message-ID: <b8329bf7-6686-4a35-bc99-25befc350e4d@linux.alibaba.com>
Date: Fri, 23 Jan 2026 00:37:48 +0800
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
Subject: Re: [PATCH v17 07/10] erofs: pass inode to trace_erofs_read_folio
To: Hongbo Li <lihongbo22@huawei.com>
Cc: hch@lst.de, djwong@kernel.org, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, brauner@kernel.org, chao@kernel.org
References: <20260122153406.660073-1-lihongbo22@huawei.com>
 <20260122153406.660073-8-lihongbo22@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260122153406.660073-8-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.20 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2188-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lihongbo22@huawei.com,m:hch@lst.de,m:djwong@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:brauner@kernel.org,m:chao@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,huawei.com:email,alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 4ED896A187
X-Rspamd-Action: no action



On 2026/1/22 23:34, Hongbo Li wrote:
> The trace_erofs_read_folio accesses inode information through folio,
> but this method fails if the real inode is not associated with the
> folio(such as for the uncomping page cache sharing case). Therefore,

                 ^ in the upcoming

> we pass the real inode to it so that the inode information can be
> printed out in that case.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

