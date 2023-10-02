Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9217B58CC
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Oct 2023 19:36:34 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kqjcOHzU;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rzp6756Mtz3cRd
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Oct 2023 04:36:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kqjcOHzU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=erik.sjolund@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rzp621ShGz3cK4
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Oct 2023 04:36:24 +1100 (AEDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-691c05bc5aaso12622b3a.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 02 Oct 2023 10:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696268180; x=1696872980; darn=lists.ozlabs.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N8s1WwDzxSHbA6rdDXc7EuKOtNH6x8h5SH4QH9aUF9U=;
        b=kqjcOHzUupz5GoNeAKlDc0QoyJK5+LlDqeery6hfNEhIO+vbUITAvcUiKL6uc2+jMm
         ksYtmwU7ESTLRAvihl0L7Ktd7magcznku5/GYbMX2ZEulNiUswGt0JOwiGQvwje1RKA7
         Itz1SR4i0trWJiD3pLo6X5cyNcOKXsBjJEaA0GQOkRa1y9GTZFLcjAlVv9/GampHM9Zf
         sGOEuG4uiLTR25oab6W+v6bfhf43ml0AuahZMLHWjY77onMg6hEWB/4xvt7Jyyb5d3hr
         IlUvQhlgE1wY0ANvcJv9o8w9lMv1SpDBLiUTcUTHqlnJvE2NQZNJ0hP0y/atNAn30fg9
         kmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696268180; x=1696872980;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8s1WwDzxSHbA6rdDXc7EuKOtNH6x8h5SH4QH9aUF9U=;
        b=TS5gbiuZN5n8HLjHbplqSZTHxHAnK+MMsxqX/iUwm1zd4+79JQb5BhBl2/XPujxrFT
         woJbGKIwCoDuxKbSIza74R4dO+MoMzpVf7w+f0w5qYyr4IIVCX2NlqZxDrsDaXJfhMP9
         4Xxy8g9+nTvur6cOrcrlkCxMOztBrXdOyYYpJIG8aDfcdjPJWyzbM2IVmsm4F2IrL/Xj
         iYgBbqM8AkXaKRGr7+PBxLQSOmFK9Qsai7ggOmcf6g6dzApOhIqmbCeSRdEe/+O2GyYM
         X5Gfbk+NW4zTzNKbtIpznUitQjZKCxHB3acdtsJQLAkNhuYuZQwZ7SgTQvs4f3fscc7+
         2z2A==
X-Gm-Message-State: AOJu0YyDvTEn8HcCyiqbb2NOUSEZt7Ho3ravdB0AF6enwp64Al4DExTc
	dfsKh+vo9ukFyg9qQAkGNBGeN0mSvkrfIwWtdJX3rbepo9vnDw==
X-Google-Smtp-Source: AGHT+IHiZa07+R5tIleBgD1Cg6eHB73Lw87DkYX3izDl/2m5oaX+dNH6mJFLxbOl+Uv/8JiMR3FXxaKmLtTaiGX/Xqg=
X-Received: by 2002:a05:6a00:b50:b0:68f:cc47:fcd7 with SMTP id
 p16-20020a056a000b5000b0068fcc47fcd7mr14456136pfo.28.1696268179401; Mon, 02
 Oct 2023 10:36:19 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Erik_Sj=C3=B6lund?= <erik.sjolund@gmail.com>
Date: Mon, 2 Oct 2023 19:36:08 +0200
Message-ID: <CAB+1q0Q3+7s1Lt8uW6DWZ7vfjhEKhG7O7MAQhCuH-C10cr9F4g@mail.gmail.com>
Subject: errno is set to a negative value in lib/tar.c
To: linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi,
Does this patch make sense?
(I thought errno should be set to a non-negative value)
Best regards,
Erik Sj=C3=B6lund

diff --git a/lib/tar.c b/lib/tar.c
index 0744972..8204939 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -241,7 +241,7 @@ static long long tarerofs_otoi(const char *ptr, int len=
)
        val =3D strtol(ptr, &endp, 8);
        if ((!val && endp =3D=3D inp) |
             (*endp && *endp !=3D ' '))
-               errno =3D -EINVAL;
+               errno =3D EINVAL;
        return val;
 }
