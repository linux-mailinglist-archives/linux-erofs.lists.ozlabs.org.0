Return-Path: <linux-erofs+bounces-3470-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAUAH11XDWpuwQUAu9opvQ
	(envelope-from <linux-erofs+bounces-3470-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 20 May 2026 08:40:29 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8950588458
	for <lists+linux-erofs@lfdr.de>; Wed, 20 May 2026 08:40:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL23Z0Ywtz2yDs;
	Wed, 20 May 2026 16:40:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=152.89.196.46
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779259225;
	cv=none; b=gmKA9lq8ivTC4AVaRo73wDBp9V/f09dE1sN/8hv/nZu7HDykaMR+W5NtjZkLqkkSsvsxh3MLKB56z1fdxTZKlg0SC3qpZnkBUQ9b89cLJB/5TCMICxcCtEJozVGIbQJ+RzN9yZtzXHhCPMusKMc/1uYzxqnjdE5exJJvAo8Ugi90ftpJMmzahztSQc4Qrj3dgwPAHed2vSzJLG4UaPhPzoVkKGwcpggDSfLkKcDY/2PD9QyN2k7Fh3yLQL76NK60aycgzubAW5YiUiphWkXQtdNi3HJFdmpGgixEwDr0sdCMYaXno3aInVuQzLVTl0Wd6ph62uQBrZEL01hQwsub5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779259225; c=relaxed/relaxed;
	bh=8g0Ujf71rFYq0yA9Y7StgZuqr0+QnZLPM+2RgWidsSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GNdxn0DWs4qcGzQ+AFdkItmSPBO51M968zwgeRxA5nDHxS0oLEDm6tulBL7paUZBMU8+PrhjpNpOGUTDcLNXH79Db6zEFHlTSnlNDEOWE2W0ZXft7qrPUGcm+h/8VWywNrXdpGArO3jmCM2ddZSxDbgFgrHZgxhYlPXOLBH8PVRGZDJWXQeNrsUvcFRqk5gqHzvTAvwslIY6IJsh6yVUXVa7+Y3SXPdMjMn9IexZSWLSi7J5cwiCl52zx5bY/guZCYPtw+NU77DcDSuk2dEPZ0iCE8CIIj0znNU6dlRznOyaDf46uEitwR8CzoN2ujBYRzaUav1/nKFE74bGuFyKyw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.a=rsa-sha256 header.s=post header.b=kjYjGH8S; dkim-atps=neutral; spf=pass (client-ip=152.89.196.46; helo=mx4.sberdevices.ru; envelope-from=avkrasnov@salutedevices.com; receiver=lists.ozlabs.org) smtp.mailfrom=salutedevices.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.a=rsa-sha256 header.s=post header.b=kjYjGH8S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=salutedevices.com (client-ip=152.89.196.46; helo=mx4.sberdevices.ru; envelope-from=avkrasnov@salutedevices.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 448 seconds by postgrey-1.37 at boromir; Wed, 20 May 2026 16:40:22 AEST
Received: from mx4.sberdevices.ru (mx4.sberdevices.ru [152.89.196.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL23V4Lk6z2x9N
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 May 2026 16:40:22 +1000 (AEST)
Received: from p-antispam-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx4.sberdevices.ru (Postfix) with ESMTP id 88B8140006;
	Wed, 20 May 2026 09:32:43 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx4.sberdevices.ru 88B8140006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1779258763;
	bh=8g0Ujf71rFYq0yA9Y7StgZuqr0+QnZLPM+2RgWidsSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=kjYjGH8SRpk9VRptrmhYFPhisUc19lMqxZeDPfXlTjVqJn5e8Maj7pNAV2cryh0gJ
	 AOqIdiazX5Lbjc3RCXHvizIOkkZR+O3W6jzL3wWV20Lpox91biMaoyJjcqDPjBB9yJ
	 6RIhl9epw6KecxERwcUvDMoa3SzY2XEfgl5eQDXubrHojAZbYaUk9KZp/bpGpG5CYE
	 07k03WjyQimY9NEi02qEVbqT6nugN+Ovm9VUEep+DF6XxW7cc0igxF69jVkCJ9H/CK
	 ym5xOzwF139QGJbSGhwzm96z7BnQDxll4UpK8YBXrMC7v2qSWu6ZRgTNHWJeLgNjjX
	 k83/fgVsWQlBw==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R12" (not verified))
	by mx4.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 20 May 2026 09:32:42 +0300 (MSK)
Message-ID: <fe724375-316f-48dc-b494-6c67fcf349eb@salutedevices.com>
Date: Wed, 20 May 2026 09:32:41 +0300
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
Subject: Re: [PATCH] erofs: fix managed cache race for unaligned extents
Content-Language: ru
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
CC: Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>
References: <20260428043431.1883069-1-hsiangkao@linux.alibaba.com>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <20260428043431.1883069-1-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.28.3.98]
X-ClientProxiedBy: p-exch-cas-s-m2.sberdevices.ru (172.16.210.3) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-AntiPhishing: NotDetected, bases: 2026/05/20 05:49:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 105 0.3.105 c7fb587251b1312ef0d9243823bef7335f8fcbef, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 203270 [May 20 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/05/20 05:51:00 #28197173
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected, bases: 2026/05/20 05:49:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[salutedevices.com,quarantine];
	R_DKIM_ALLOW(-0.20)[salutedevices.com:s=post];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:chao@kernel.org,m:linux-kernel@vger.kernel.org,m:kernel@salutedevices.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[avkrasnov@salutedevices.com,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3470-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	HAS_XOIP(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avkrasnov@salutedevices.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[salutedevices.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,zbv.page:url,alibaba.com:email,salutedevices.com:email,salutedevices.com:mid,salutedevices.com:dkim]
X-Rspamd-Queue-Id: A8950588458
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 28/04/2026 07:34, Gao Xiang wrote:
> After unaligned compressed extents were introduced, the following race
> could occur:
> 
> [Thread 1]                                   [Thread 2]
> (z_erofs_fill_bio_vec)
> <handle a Z_EROFS_PREALLOCATED_FOLIO folio>
> ...
> filemap_add_folio (1)
>                                              (z_erofs_bind_cache)
>                                              <the same folio is found..>
>                                              ..
>                                              ..
> folio_attach_private (2)
>                                              filemap_add_folio (3) again
> 
> Since (1) is executed but (2) hasn't been executed yet, it's possible
> that another thread finds the same managed folio in z_erofs_bind_cache()
> for a different pcluster and calls filemap_add_folio() again since
> folio->private is still Z_EROFS_PREALLOCATED_FOLIO.
> 
> Fix this by explicitly clearing folio->private before making the folio
> visible in the managed cache so that another pcluster can simply wait
> on the locked managed folio as what we did for other shared cases [1].
> 
> This only impacts unaligned data compression (`-E48bit` with zstd,
> for example).
> 
> [1] Commit 9e2f9d34dd12 ("erofs: handle overlapped pclusters out of
>  crafted images properly") was originally introduced to handle crafted
>  overlapped extents, but it addresses unaligned extents as well.
> 
> Fixes: 7361d1e3763b ("erofs: support unaligned encoded data")
> Reported-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> Closes: https://lore.kernel.org/r/4a2f3801-fac1-42fe-ae75-da315822e088@salutedevices.com
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>


Tested-by: Arseniy Krasnov <avkrasnov@salutedevices.com>


> ---
>  fs/erofs/zdata.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 8a0b15511931..6b647e75ec04 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -1509,8 +1509,15 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
>  	DBG_BUGON(z_erofs_is_shortlived_page(bvec->bv_page));
>  
>  	folio = page_folio(zbv.page);
> -	/* For preallocated managed folios, add them to page cache here */
> +	/*
> +	 * Preallocated folios are added to the managed cache here rather than
> +	 * in z_erofs_bind_cache() in order to keep these folios locked in
> +	 * increasing (physical) address order.
> +	 * Clear folio->private before these folios become visible to others in
> +	 * the managed cache to avoid duplicate additions for unaligned extents.
> +	 */
>  	if (folio->private == Z_EROFS_PREALLOCATED_FOLIO) {
> +		folio->private = NULL;
>  		tocache = true;
>  		goto out_tocache;
>  	}
> @@ -1546,14 +1553,8 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
>  			}
>  			return;
>  		}
> -		/*
> -		 * Already linked with another pcluster, which only appears in
> -		 * crafted images by fuzzers for now.  But handle this anyway.
> -		 */
> -		tocache = false;	/* use temporary short-lived pages */
>  	} else {
>  		DBG_BUGON(1); /* referenced managed folios can't be truncated */
> -		tocache = true;
>  	}
>  	folio_unlock(folio);
>  	folio_put(folio);


