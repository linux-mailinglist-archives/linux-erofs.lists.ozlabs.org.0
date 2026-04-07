Return-Path: <linux-erofs+bounces-3215-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cB8hHT711GkjywcAu9opvQ
	(envelope-from <linux-erofs+bounces-3215-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Apr 2026 14:14:54 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC713AE300
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Apr 2026 14:14:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqlWH3d83z2yZ3;
	Tue, 07 Apr 2026 22:14:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::102c" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775564091;
	cv=pass; b=oyU/2DsXpAiJjn/6zdfMgPl4n52Aia9WkKhAZiuMANIDulxYUxjSOYiD9m3sc7raWyKJ0ETBxgWfxXOjg62p8OEtuhRpI8g27AmBjeDhbtdfRFsmQK4BVEEbD3nlcR5rTDZg3xtBz1qfwHFkvNRNynWD4MFJxFvmt4qLWxe90WX/q6/kkISRIi99a+BrJWuhXbWmBkk98vuEMtib+Mjtdw7foR6HmqRZMr7iSbR3zVrqHITH1vqEA3C+IS7k+/gReD8vMmJqCliKAZrkOLMaCEekl+0tYZz/z2FFtaMDR7fKHcMl4+FHtcgTwFthiy362w+Ibwhv1wK/ix5Zg9zySA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775564091; c=relaxed/relaxed;
	bh=zTDkABRGJ7UHzKZMFM6DSH1URUE3mRRr3uWbQhi8EKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vne/VhFcn8wPwhUwWXkhb7olQqywMsalZsWg7CyTJ7jEmGTGlBpfVe7bbNRerLQND7SreKhsQSOEZVks/wS1zdb1e/peSp7Pa+LTRuDo36Pgh4SSE+9wfdyOW6siyxYzw5KwYOP/x93kpHgZNKA5g6RGZrkpOCxSXWKMkv5180N4x/fnDdvVaTEn+EgxFBeb1pims2/RKPr+8OTJ4kkqcDDArx766fBJHXmzMo9I6HJAIQvtQgtYzE/yjEI3dMba778paytPFYa/soQ39jL1wE1tdQqh2lQJ1poe6d7yLwWkxJY5xSElktxhqLsFPwglTF/mSf56Bk94lfCEe69eAQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SwtPiM4R; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=stephen.smalley.work@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SwtPiM4R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=stephen.smalley.work@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqlWG3q1jz2ySk
	for <linux-erofs@lists.ozlabs.org>; Tue, 07 Apr 2026 22:14:50 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso2836555a91.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 07 Apr 2026 05:14:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775564088; cv=none;
        d=google.com; s=arc-20240605;
        b=UVfjxTU21twdhtWBRFgTMCy/duMUGB+p0yW6RSg5ARs7Dv7YOpw8/aE9uryXbUuyli
         AUBaLjpVbuVzk7RbDnWVyV2juqAXj/yE5pWG7Vdl9XnjCUCkdKaTTFrbogoq54q2vFCI
         8Mx0gNQuZoQ0cXSO/qdufeBnfg1RLOnMpieZnJfnCjurJzuS/8/ycsVe+pUVKG9S6tX7
         gDXPUWt09IiI6IZaH6leHXq2/+H8Tdkt0PpYQnBihlMnqq2+dRxYYyG8TsNLsJI2ET4K
         +zA3EGI4CTawpW7fK/c+Qyv1FFmupDv9v34AEZpaHI9qqxRae1LakLMpPtEIXouiDzN5
         GMDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zTDkABRGJ7UHzKZMFM6DSH1URUE3mRRr3uWbQhi8EKg=;
        fh=XHWjd4N+J8gseRBoXHpORxOznqV35McvTR9G/hXco80=;
        b=bECFBA5ofoMaImbCh1aL6y0iA7DiCoT5RrTvVKXVsEwe4Spm+dFojmc3GZSUmJzWyg
         VQ3l6nw1MwsuXdtew6fnQuLes9FoozD3JJVUcOb2YjZPx0T+krk3nVat29YK2MVyGi7T
         MEx4bt5UOHUXsqnv8P3ifprTV59R++1mhpXApbHh1PTkYfNyNRl6qQ78foGJ9IhLmRHy
         ZPdBI4pcvRAWN0ywv0WviU5Fy+/8GTohNrqqubEu2e5gYrYBNnyTfBqN9k5qirYmU413
         oBhaOLTkAB+xSlJC87gnqlUhxtNoTp/fpllG72mBos9e5HcLE3q4MNs6yD32LSpddhW7
         tM/Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775564088; x=1776168888; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTDkABRGJ7UHzKZMFM6DSH1URUE3mRRr3uWbQhi8EKg=;
        b=SwtPiM4RdN76cKdyxhbopnklUPZcANVuSVuPkErml4hML7o0kHjJ8VQPSEzL7KlKG9
         QgyBb73rqejZGCQqQkuJtxybRb+dUG7fh4rdd+C+oR+XBIRdHxCwjIR8zWz7BtKokd54
         MF+ArDlJojS/TH8juzQ71jKJHUL/6fLXHtgZRWpVVM5wEmu2TNPgOmwF8bEwfGv0veHu
         m9ot0NoDnZfy4oyvrYLDMAcDy2chiJGJfKsxaFOTpgL4ZrwAgDQIeA+g+aMnumCpPaWR
         Sh4JLKE44VmqquVKk0crIW+Bat9dSaFyGa4vXLl3fVGm75/XbHRGTBYbpR8Aq3XTaqec
         fJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775564088; x=1776168888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zTDkABRGJ7UHzKZMFM6DSH1URUE3mRRr3uWbQhi8EKg=;
        b=SAiG+R89vRS7b2DOvx6bHl6p/ro3aqrL9m+H7EdHqq6ncnsXUCE9VMzJxoNpCxMP9M
         gphfqYo1otWk4OxuETW/WMl+X4gCY7SMhTKFf302Bs2ncgWVYq4/bVv0XX1/14UgOOpf
         MehSer6KugU4wJT0BCPU5QVVnhca+su5JiE/26sBUne8alnroiK1HBwt77+udw5YpLSZ
         En8oosV4cHWIrEmCMEikydaVt3SY+r/M1/JbP6fuQBjQxJgBP3lobA7/DZxP6H0UNXAN
         S3qw7YM46n4btJlPmRKFXB6m0tQDKK6z3drZEJlvCwteECfCxJN+RSxwjg+M00EF3BXu
         VsHA==
X-Forwarded-Encrypted: i=1; AJvYcCUkVNaN2PY2rTQ9ozMoLnrUTWxBfQzQC1oFv9E+kRMPyKQ3Vg+sYFiThNq6JdYmEC04i6e5VvZKQKZ3jQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzc+JFeZk0YOC2978FEHm2SeFk/h3Ic/cFinRnEWNLJHluz+afc
	OYfBWJUGBR60XcVcpdlrwjv+qec8M6hhRbR5xaNyvekqV/3KnpICHBPIMhpBbcDb1/ruxS0QJLs
	I2VmYLxN6i6NjbOyBn9//nXwx4rFnx+78jg==
X-Gm-Gg: AeBDiesGVaRJ5AvtqnvY0r+vQ9DLu+N1Z3k0p/xg2xXPZjxg/cqn1UUCy2cUnyAZtwd
	qBxcQdUW+IjVY+LGvLlh1+LQxaRd8CVbwqqQUjfI6hPgKgVS9npU4+Y//+khoNZTbgbtAccFhy8
	onwXaYjVvRM+iE9AytivqWppNzXTqVMp2qoOBgUcgQxTHd68IonV7eUL5/wBLsQzMRHRJvnTwIr
	T0uvhnwuysb1s6nUHosNw46zTVVOSaKT7y+hDcNke+lOvu8n8sg5dlrQI2WrUwLue818+NJ5Of3
	E4sJVJ0=
X-Received: by 2002:a17:90b:3d4d:b0:35c:d37:6024 with SMTP id
 98e67ed59e1d1-35de67ea9d5mr15645164a91.11.1775564088070; Tue, 07 Apr 2026
 05:14:48 -0700 (PDT)
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
References: <20260403030848.731867-5-paul@paul-moore.com> <20260403030848.731867-8-paul@paul-moore.com>
In-Reply-To: <20260403030848.731867-8-paul@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 7 Apr 2026 08:14:36 -0400
X-Gm-Features: AQROBzAHeiE5r-KOh8TmARe6SlYgAd0n8yvhwUwHmTAae_PdDX5ZmAScFcPTcfU
Message-ID: <CAEjxPJ4nqeuPhve3Fe-tFuNW9R5grnWwfYJv7q2cRu+UPQ5c4A@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selinux: fix overlayfs mmap() and mprotect()
 access checks
To: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Amir Goldstein <amir73il@gmail.com>, 
	Gao Xiang <xiang@kernel.org>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.ozlabs.org,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-3215-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[stephensmalleywork@gmail.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:omosnace@redhat.com,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:amir73il@gmail.com,m:xiang@kernel.org,m:brauner@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephensmalleywork@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 9DC713AE300
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 11:09=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> The existing SELinux security model for overlayfs is to allow access if
> the current task is able to access the top level file (the "user" file)
> and the mounter's credentials are sufficient to access the lower
> level file (the "backing" file).  Unfortunately, the current code does
> not properly enforce these access controls for both mmap() and mprotect()
> operations on overlayfs filesystems.
>
> This patch makes use of the newly created security_mmap_backing_file()
> LSM hook to provide the missing backing file enforcement for mmap()
> operations, and leverages the backing file API and new LSM blob to
> provide the necessary information to properly enforce the mprotect()
> access controls.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Do you have tests for these changes showing the before and after (i.e.
failing without your patches, passing with them)? I tried running an
earlier set from Ondrej but they failed.

