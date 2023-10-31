Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CC47DC673
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Oct 2023 07:20:41 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=fotliDyt;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SKKkv2Lqmz3by8
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Oct 2023 17:20:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=fotliDyt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com; envelope-from=torvalds@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SKKkm60PJz2xHb
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Oct 2023 17:20:30 +1100 (AEDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5437d60fb7aso89455a12.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 30 Oct 2023 23:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698733220; x=1699338020; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iDMKed0nzokCCbEBIpnlAR25vjS6WyJ1gGNxVZ8+dQM=;
        b=fotliDytt5/ACNIDV/HM6MffNNGsbJt8PYm6dvnH76U14QK8xIEoxDwJBVpROapQs7
         cxNFgEsqn9OHwWANw9OeA6yXNZZD+TxG+T1jfMmDGsatgA+eN0P7lCCOMxebaswli0q+
         4wn+wBr6nGfdJGDlmhYbnld2thGceCf2Hdt3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698733220; x=1699338020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDMKed0nzokCCbEBIpnlAR25vjS6WyJ1gGNxVZ8+dQM=;
        b=Y0IVXocfVprYzifvnFq44oNj1SM+4sOEO6e5dDOrTV91t+vlv/o2e5NJyEpiJijXms
         rHP/DJVC5Ulh3irFychifDpr+ILyqcDJRmj3/umR1TXoSuYk7eR1Zexo/oD3HacI3qnA
         Ed1JdcKYOFA+D8DjVVyiPE5wbSJze0/z0mSgZHW9vnrhzX7ZV03Kpe1rJPfRNwo3Luxp
         elPQPhVh76pjxWPXOUEZvN9yseKEUYHiU2fbdtOK9BIYWCTONwpTYaU0is8NRLEiahJz
         ZE07IHY9ma3HSulla33Tyn53kumxsk8jsR7pUx/bv1A0uB131YOj4Iyd4D6eDwSAH6Qv
         e2Hg==
X-Gm-Message-State: AOJu0YzeO+Md5pyLyBA5haHYGWLwoNR58hNJ2CV5q9veFKyqb/eKsVDj
	MzE7eS7xPkTBXHhVQrlzCcsCUFXyBqzptLMIqatR1xDR
X-Google-Smtp-Source: AGHT+IE38j7i/fZ7hbA7M85BFRoG0dBf2XsebL/ME1bhUyohBxKznc78vj305k5CvdDcOQb/RYCvig==
X-Received: by 2002:a17:907:707:b0:9d5:9065:90a9 with SMTP id xb7-20020a170907070700b009d5906590a9mr729703ejb.45.1698733220413;
        Mon, 30 Oct 2023 23:20:20 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id kk17-20020a170907767100b009bd9ac83a9fsm392666ejc.152.2023.10.30.23.20.19
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 23:20:19 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so8498841a12.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 30 Oct 2023 23:20:19 -0700 (PDT)
X-Received: by 2002:a17:907:6095:b0:9c7:54a1:9fe5 with SMTP id
 ht21-20020a170907609500b009c754a19fe5mr9489304ejc.49.1698733219178; Mon, 30
 Oct 2023 23:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231031060524.1103921-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20231031060524.1103921-1-hsiangkao@linux.alibaba.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Oct 2023 20:20:01 -1000
X-Gmail-Original-Message-ID: <CAHk-=wiDZXndsFtCCebQGCxg+y24WtOEMF0P24W4zPMA6VPiyQ@mail.gmail.com>
Message-ID: <CAHk-=wiDZXndsFtCCebQGCxg+y24WtOEMF0P24W4zPMA6VPiyQ@mail.gmail.com>
Subject: Re: [PATCH] erofs: fix erofs_insert_workgroup() lockref usage
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, 30 Oct 2023 at 20:08, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
> As Linus pointed out [1], lockref_put_return() is fundamentally
> designed to be something that can fail.  It behaves as a fastpath-only
> thing, and the failure case needs to be handled anyway.
>
> Actually, since the new pcluster was just allocated without being
> populated, it won't be accessed by others until it is inserted into
> XArray, so lockref helpers are actually unneeded here.
>
> Let's just set the proper reference count on initializing.

From a quick superficial look this looks like the right approach.
Thanks for the quick response.

              Linus
