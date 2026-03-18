Return-Path: <linux-erofs+bounces-2817-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tiPqL9AKumlHQwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2817-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 03:15:44 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4942B521F
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 03:15:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbC9831DBz2xQr;
	Wed, 18 Mar 2026 13:15:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::42d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773800140;
	cv=pass; b=kNeSNdCc2oqKHrD7wTtHIrU0OTzTnSLFME4dS6SszaYbzy3UXnTnjxEuap/4ygJ7+4Hm3JNkcwS/pc4UjWFZMPsGhdmEnP0jlkxT7RrFVzrjbNXpunlfhtbv/0t3WgXlRfbIrCE0UXQu/vm1uTxUif/z52ou8DDOAlGC1p3iufXfzYrZpBtyl4jauqBdImxdmSwvH8ztj2ocf1PGkXgyQQzAR9l5fXTYodg/R8IXeM8RfeW8s2SH/EYA8WB+cR6OtPcvJyD9VrXnPFsRpFzTLgA2zuAh3niud2RBH8zgmAUjGmUxRyXP8sRhzsIs417Oe7/Bx6u+sBs4ktdUIUXNWA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773800140; c=relaxed/relaxed;
	bh=u4cudNKbCONfcU17GihuTaX+2eMgwzIZSiH+c/xNhxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FY4o0MpYyPtKSaORruaJIGki+k/GTzuGfKjuLna/fCs/hUS5f6U2/sGTS7FAqpkwu2nFExgoe+SOcFfMYeiTM3YYUKsHpiMXK51TeY+f+biNq2KwaM6i9bishc/QyecfqJJenPNPmv2UwGjFS08sh7EUmhKj1//owyKCCoCYNgBwiG15NNYW/Ld7mjBqlfajqQD3Zvi1g3l8MKduNoKidf01fCy1jvCINHFPLn5hFJWJNx44uCo74paLx+z5WZd/G/GC98SWrbMyjLjCODNTSWpxn6Z4uhoxiU+anAduhXd3g/7IqG8GJx4H1YPKxKJnN8cQHTy4utE1stsBt9YfdA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=eERzNrP+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=stopire@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=eERzNrP+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=stopire@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbC964PYMz2xQ1
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 13:15:37 +1100 (AEDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-8297310ce0aso3420785b3a.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 19:15:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773800134; cv=none;
        d=google.com; s=arc-20240605;
        b=EYRZ6VNkvjaovGlnm5zp3Op8h6JkngyR3bQdjlVF/0EPDIPTSzYa8PPwZ60j3JTK/o
         XXh8bVEvqAL5DGUVfVFt2wH6hMI5L0KgXFJegiar3783ZlIE+I9Fu4Ss/QxeS2Dbofud
         T8BKSR6sUNRdq09vTiVi2AfNGN6jTeTh3nQPxKSGWv+96ODrc4Od06zf/pnQ7d3+CeVL
         jDBS9tqh+LYjljHreILEfRhWiHvT6ktSDzzICvSEQ/wJ6o+vmTkENn6PXYjTxFusq/WE
         aMCGsBLW3fcyie/t3LKgLrZUmWdmaldBflUQQ+hFTtMS712xw8D8NU3jlo81zs/jrcQh
         FKwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=u4cudNKbCONfcU17GihuTaX+2eMgwzIZSiH+c/xNhxA=;
        fh=91tKRfn0NNmqxFz7I2Y5jRKaNQq3qMtO+x1FgaI/+v4=;
        b=YKSPt/6LukVfvQp3v2GRJ5xYRB3hoALeGeihVm66x7cZue/czSMDU/priRFRrUg+jy
         oxqDxiKD4PII7BEoFJNWVSr1lb1LSasv82Rs4jROVfGBstQbuegR8hLk3KMyAt9MuwCj
         AhlT8q4hSD9mw72JC/fZv0Lq5l1lkZGUBPjOIfgbBfD/kIEiQeaJZe+lp4hO+DQghedl
         rdgEJdnh884Ick3KzGtaEbvWobYXChpYB8MYQC+PU4GL6/qKW2EoQN8zJqcaeoWhv1Aw
         WV+6fv4R+xS7JZ9o8XuDI3y+wKKWAwy8k6nbnW/cWwOLrrFe0qjhpPEJ0nRzpX9w393D
         xNKg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773800134; x=1774404934; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u4cudNKbCONfcU17GihuTaX+2eMgwzIZSiH+c/xNhxA=;
        b=eERzNrP+DQVKkZns6u+GvYgiJT3YJurJsSYUyC8nRtPou4ZxG10doYXslVXmKtkdjm
         4qCL38Z7IHS1nCENRK9J10cvmS/DA62lS3L1JzSOjADVmulqEsUE9X1Drbi11OJTSujD
         Va3GnA0cD8DWUfP+ZbeGq6XiJ+qiIMpOb7u325hhargu7bTN8dhci8zpQpdbP+jYdmy2
         t0g0ZdRC40Jx0YCUYRvolXm5Ng5e9N5pbNObsyUPD/yU+rFXTRcToqiwemSwc3REPkpk
         6btcsJtYy/AKKPb4O5Lfwx00yXh3CVrNc+jUncSd3Rh7jTtmvq4Ig6RX5RyYxCjTl4nt
         yzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773800134; x=1774404934;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4cudNKbCONfcU17GihuTaX+2eMgwzIZSiH+c/xNhxA=;
        b=YMkXYy8gjBSLjjaelOXriJTiMvGhV5WUO+SgLWWHlSGEuVlFTjHG0WhnaKQKRJI503
         7dWMx0mY2ivDFyD1FXg7dhEsZUuom+gFdoY1lDtE6wvVXg+KAFmhS5nzqO2TLxXqhA9j
         ilsYbbPo5p9Ync9aP4ApHXvnZsV9Onw+5p9BCQNOU/nYD0PLZPkKSGzOZb9DVA34RzKw
         h42urd9eA8g85bD9DtquibYFPpS/x/PhUEmrGNpim+0pFffs7I7EHV3vjWQo68t3rBSa
         wJ6ev1wQJpO1Lx4CwSvJDiFBxN/SDAOYf0Q4wzpgXDt4NOOibY5oYh5zpKJWl5q7QZVH
         e1WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx0+H4IKNG1T7tT765yZl65ghdrIxv7CyhChvIyovXbJlkHVD0MGClNtqvJYSl7DM4Db7k77F/NTE/+w==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyleAlQBlMtpCBUZFCfSUPmLD5VTxb2BADsZ5Wul2W1/wQeo5sp
	w2VyZe3FncAkhzf+9Myw6ShmnBBaBusCDzgQTxT5B/x6kNsREoTtmDI+qEH7prLWCBuUH3Hdwt6
	mwsGoOZ9aGDoV8xdW0F7ibULeB3cCPIs=
X-Gm-Gg: ATEYQzwEILWVeWowpcQme653dEe/TNuQGBtYt/QdApDztTrwgA5TgO5/t7TcX9HO/qz
	8NTzBfac1PpGjevNBs9PHf+3JzHMh/60cFODsVotgZTI82BRZQ29+dda5iG0BDFHujfAoHsXxOL
	CpizWayk4ytPo5RpeoTfGCor3sEVcMihkaCm0TdUXRA6LRZo+rey5DalDgD04Wv5pzCfH5vT2zE
	Bq7RhCj01j/DfkJ92bZoppsx/GU08C0SvJRIq1Ao6p6GxKVdFX0oG/q7zTW8sgGFJL6MGOAUqFv
	FI+jcLVUsNoTAbx4JuNIQifBUM21UCHGoLvaC55d
X-Received: by 2002:a05:6a00:18a9:b0:7e8:4398:b34f with SMTP id
 d2e1a72fcca58-82a6aee1883mr1418211b3a.34.1773800134201; Tue, 17 Mar 2026
 19:15:34 -0700 (PDT)
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
References: <20260317043307.27575-1-nithurshen.dev@gmail.com>
In-Reply-To: <20260317043307.27575-1-nithurshen.dev@gmail.com>
From: =?UTF-8?B?6LW16YC45Yeh?= <stopire@gmail.com>
Date: Wed, 18 Mar 2026 10:15:28 +0800
X-Gm-Features: AaiRm53u2nE7jrIao6egrxJ8HEZYtExXis0RNKs48gsaGmVwzwnj5hWNLypl8fI
Message-ID: <CABra5+1T-FH54LSYF=Nz1UDrKVX47N32BS432TPo3HEAFJQ10w@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: fix thread join loop in erofs_destroy_workqueue
To: Nithurshen <nithurshen.dev@gmail.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, hsiangkao@linux.alibaba.com, zhaoyifan28@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:hsiangkao@linux.alibaba.com,m:zhaoyifan28@huawei.com,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[stopire@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2817-lists,linux-erofs=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stopire@gmail.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3B4942B521F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/2026 12:33 PM, Nithurshen wrote:
> Currently, erofs_destroy_workqueue returns immediately if a single
> pthread_join fails. This halts the teardown process, potentially
> leaving orphaned threads and leaking the workqueue's mutexes and
> worker array.
>
> Refactor the joining logic to unconditionally join all worker
> threads. Capture the first error encountered, continue joining the
> remaining threads, and ensure all workqueue resources are properly
> freed before returning the captured error.
>
> Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>

Hi Nithurshe,


I'm afraid I cannot agree with this change. If pthread_join() fails, it
implies that the worker thread is still alive.

Cleaning up the synchronization primitives and the workers array at this
point would lead to a Use-After-Free issue, which is far more severe
than the current resource leak.

I believe pthread_join() seldom fails, otherwise it indicates bugs in
our codebase.

How about just leaving an error log print for this scenario? cc @hsiangkao



Thanks,

Yifan



> ---
>   lib/workqueue.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/lib/workqueue.c b/lib/workqueue.c
> index 18ee0f9..23eb460 100644
> --- a/lib/workqueue.c
> +++ b/lib/workqueue.c
> @@ -42,6 +42,8 @@ static void *worker_thread(void *arg)
>
>   int erofs_destroy_workqueue(struct erofs_workqueue *wq)
>   {
> +     int err = 0;
> +
>       if (!wq)
>               return -EINVAL;
>
> @@ -53,15 +55,17 @@ int erofs_destroy_workqueue(struct erofs_workqueue *wq)
>       while (wq->nworker) {
>               int ret = -pthread_join(wq->workers[wq->nworker - 1], NULL);
>
> -             if (ret)
> -                     return ret;
> +             if (ret && !err)
> +                     err = ret;
> +
>               --wq->nworker;
>       }
>       free(wq->workers);
>       pthread_mutex_destroy(&wq->lock);
>       pthread_cond_destroy(&wq->cond_empty);
>       pthread_cond_destroy(&wq->cond_full);
> -     return 0;
> +
> +     return err;
>   }
>
>   int erofs_alloc_workqueue(struct erofs_workqueue *wq, unsigned int nworker,

