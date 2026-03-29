Return-Path: <linux-erofs+bounces-3082-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJNoIzKPyWm1zAUAu9opvQ
	(envelope-from <linux-erofs+bounces-3082-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Mar 2026 22:44:34 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 050ED3540DA
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Mar 2026 22:44:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkRFV1BvVz2ySS;
	Mon, 30 Mar 2026 07:44:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::f32" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774817070;
	cv=pass; b=M5+eM2WwQj43Xj5eAPEBTvM1yjJSetZT2rQpycQRyqZo0Z38y39s/YIe3fNacmBR6IR9OxHHfep4RvorsNPSvZbf8fJGsRRVrSZ+XsVEIsyf59rQxUs4QUL9Ovy8nb6L25yF/n1/b2qkiUxv5PwoY4wX61U8wBYycVBNuPDkHP05s9mot2ssN05pu7jVVm/D8KBB5hOnhMRqtqpAfhU/YpTeSbbezv50XZ7eIOX2UwzkNP+k2RoHgmA4nqXpiPdV2FrgvAT1TyL/y3lSVNkEoUJ0pgPK4hgP1pJY+qn+Lndqv11k9IBcsp8OBTb0RPQ2UfS9GspdhvtS7dVYk7rDBw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774817070; c=relaxed/relaxed;
	bh=uU8bFPEvKYOQUgi+XUOz8oLFKOybQuVC9Y19ToBOkuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhUErm812X04d12JjqDSHxi0vgVxApMCQnuXgyCNsawDa/cUvW+J8OAvHRqOxOSMxddkLOUFYzb4I33rAFvT/AT+fwEtX+50cG++ar2/g+5YmZwLLdSmP6fSdU7UUcVYGiAfJuygyFtfdEUDV7PITHL42u9gHl8+lPlwts+RRHHBDsz0iEh1C076X0ZTDyWdJXOwMopMNTj2PXixIPRdiIeA9pKlTke1wxuJfnFfmfwPiXm4aAqk96zaP3FOHR9gOdLU3usnU2AKzMiOY2eHTCsqOeis09XVL35UDRf0sJBnjbG+cZttlpFNyXUyAGXOTPOfSEZC7s5UksGPjs9BTw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H4pRLgYL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H4pRLgYL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkRFT1V0dz2xQr
	for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 07:44:28 +1100 (AEDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-899f50ab3f2so7182306d6.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 13:44:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774817066; cv=none;
        d=google.com; s=arc-20240605;
        b=MDD8iZChWj+2ZRPhssrQK5TXGY7zyK3XLByI2OI42az88oi2MLLAV/dllaTX6giHtl
         T4Aq/APGnAbKEyEj35BJloEoGvKqleyfCjUM1mHU5BOOy9JQNo2OWQf2l5Qkc+g2jO5M
         /6eYYwEisT22jcW1cnQNyfp/VQoa30wztjYr6iizE496LCgcb7/MGyV0CJuYkeIjTKLI
         j3CRezUZ4fumoQFufE4NSMsGD04/JN+9innEVrIIHoSw4KfdNlorCg9dFyS/Bjc7QqsS
         sq56SwFwJPh8TOgDsnpxR4V9wwJqxnTRr+y0JVjrFwTJL3XglmsD2ICzmwDrUmLxg/5k
         9Jsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uU8bFPEvKYOQUgi+XUOz8oLFKOybQuVC9Y19ToBOkuA=;
        fh=rFIjmt53n1zfWXgPux8IqwKbHHpRVZET4FCyNME6lW8=;
        b=k9NchKFOrZWx3MWPGnZ/Q6m84oRcY76LjcuSEk7Va2mmB4XjRzIfX7voiU/Ix/Nqki
         BQE+2djPnG0wHJPFfe7P2V8IdsfABhStxNSM/3ML3ibCWJzhA8aArig+LCy/t2nRBEDq
         O8kJsrrhGU5WgjS7AbuCHfFbdsS7wbjuKs1dOPkO350oTAMAanmSm6soGDQQtRfUtjn+
         oCCOrrXpoeNpr64WDlWEHzrQ8ulz19LkqOGh2SK3bTeuy+l+gjB6Pi0MaojqHH4+GSf5
         LC2+A9Zgvnf265/YM6mtBNXueIrLsV3V2VSyFZAAXrl2NWhyQ9RNmPfk99LLFeGRc/7t
         pM1A==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774817066; x=1775421866; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uU8bFPEvKYOQUgi+XUOz8oLFKOybQuVC9Y19ToBOkuA=;
        b=H4pRLgYL1vN68IiaQ+kN0M+tlUaJyKWUVZt2oflXgmOXb+ZcVPMVGjkQcZYD+aOX36
         sMtp1QrAgecpQ5qI+0MxU/iWxiGsdXjScjOBWg+I60TV3laakIOUCiq0HPRGAB/DqjC4
         NSRACBX4UvSaOnaXFUUdtLnELeWrDV8KvWILkp51BU391V4C8XqqH6huJEqOwLWXAE33
         QlyMcGG7jCXfadflFQi+CWK2DWqdhiALtQpq8+XGyVzqRswLxwDEeUjLFT+PIvbMJ4Vq
         t5HB4W+UZmvst4vDDZkjsZKE+uB5/xtofAat8oKCMoHP5XpNe/DslLO6RNG4J/sFYXJy
         eTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774817066; x=1775421866;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uU8bFPEvKYOQUgi+XUOz8oLFKOybQuVC9Y19ToBOkuA=;
        b=dCN1g7c9QQ7TkmkNPoVkhmAwyDLgyaVLprqhd7XyLHDPZwlXsT7WJzK3+RWQS/KkrU
         RHq4r6hFMFA+8xbu6Kr/sl4GLD5YG1xor9SDkcjTZewUHnDYmKfUoa/bXwotRFBHqzen
         hXRFx1o5WY0y1ch3cdLP3sQiqKfE8gdEN5+nackDxpJDGys4DxlPiCzW9lO/64AjsJih
         TbL9xqso8ObRuclGyWMz5uzjxracF4Q3grmXiXZ7GhDbdzFFvp0bsDDu4pssS0IQFk18
         hQmhowbmH9heBAQhYHmPyNT2lL+xFguwosckA5EpRr1Cm3IfAzzV2CzakabG4ZniMShE
         WHuQ==
X-Gm-Message-State: AOJu0YwQ5SVDNgHPr0y29uqLRUKxmq5oYBfzgTgZTb9QIOXlPcXHNR22
	cthuQOm8nl75TvWT9cJk/UrS4NV7z/Yp6yf2Rx4yVabVuc9u5/uyhupa0U7S+m4Bzx1UihpY9JH
	+l9ldOyKHcRJYA/X1D477zwaEg2ja5OwDnliznVs=
X-Gm-Gg: ATEYQzwhbC7dgINENJqzPQlkQWZTTQJaIt6tUHQCWuv9NmokVN7sX5/FNZo1d30gIuQ
	7uWaLHs+KJPK/R/+dTUKsc/EfmHFmsGIDDrV6KNjFdz5eztzv0gIPgfLzxdrTFw9LTyBQAayPB1
	KXYe4BgphuNb6tYMyrQTkjv0052LV9HFI2QfqOFS6S+/W7PshF49nSP72KpNIuEjS37o6S+f+Ot
	Xc0eDDJAEG9VmpQm1Gezaq2JzmOnxusRcbPE6/kovadwd6z9Vt+sGXI5fdnYrKuey8vOw9JBBqd
	6xFEawtTQJlXBaY/ZayB3nLR92/uL18Bsxs5f1VzfldQ29VIRQiNvyHCYDr4s1wBhlu75w==
X-Received: by 2002:a05:6214:401d:b0:89c:5159:ea52 with SMTP id
 6a1803df08f44-89ce8e9878cmr108366676d6.7.1774817065639; Sun, 29 Mar 2026
 13:44:25 -0700 (PDT)
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
References: <20260328132047.1869-1-newajay.11r@gmail.com>
In-Reply-To: <20260328132047.1869-1-newajay.11r@gmail.com>
From: Utkal Singh <singhutkal015@gmail.com>
Date: Mon, 30 Mar 2026 02:14:24 +0530
X-Gm-Features: AQROBzCU_JJi6lFUUgQyR69u9OkAoeS3vVFtJfX6vqiCEmOqL4MYYhbRf45Ha8M
Message-ID: <CAGSu4WNVJupFg=9Raz3Pyy483Wo6g-vOFjWFc382bMi_NWLL-Q@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: fix EINTR mishandling in erofs_io_read()
To: Ajay Rajera <newajay.11r@gmail.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3082-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:newajay.11r@gmail.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:newajay11r@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 050ED3540DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Subject: Re: [PATCH] erofs-utils: lib: fix EINTR mishandling in erofs_io_read()

On Sat, Mar 28, 2026 at 6:51 PM, Ajay Rajera wrote:
> Fix this by setting ret to 0 on EINTR before falling through,
> matching the existing pattern in __erofs_io_write() and erofs_io_pread().

Hi Ajay,

The fix is correct. Placing ret = 0 after the inner if-else is safe
because the else branch always returns, so the assignment is only
reachable on EINTR. It correctly handles the partial-read case too:
After a short read advances i and decrements bytes, a subsequent EINTR
leaves both unchanged via ret = 0 and the retry continues from the
right buffer position.

Reviewed-by: Utkal Singh <singhutkal015@gmail.com>

On Sat, 28 Mar 2026 at 18:51, Ajay Rajera <newajay.11r@gmail.com> wrote:
>
> When read() is interrupted by a signal and returns -1 with
> errno == EINTR, erofs_io_read() falls through without zeroing
> ret. This causes `bytes -= ret` and `i += ret` to execute with
> ret == -1, corrupting the byte counter (bytes wraps around since
> it is size_t) and the offset. This can lead to incorrect reads
> or infinite loops.
>
> Fix this by setting ret to 0 on EINTR before falling through,
> matching the existing pattern in __erofs_io_write() and
> erofs_io_pread().
>
> Also fix inconsistent whitespace (spaces instead of tabs) on the
> closing brace and return statement.
>
> Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
> ---
>  lib/io.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/lib/io.c b/lib/io.c
> index 0c5eb2c..dd5e304 100644
> --- a/lib/io.c
> +++ b/lib/io.c
> @@ -551,11 +551,12 @@ ssize_t erofs_io_read(struct erofs_vfile *vf, void *buf, size_t bytes)
>                                           strerror(errno));
>                                 return -errno;
>                         }
> +                       ret = 0;
>                 }
>                 bytes -= ret;
>                 i += ret;
> -        }
> -        return i;
> +       }
> +       return i;
>  }
>
>  ssize_t erofs_io_write(struct erofs_vfile *vf, void *buf, size_t len)
> --
> 2.51.0.windows.1
>
>

