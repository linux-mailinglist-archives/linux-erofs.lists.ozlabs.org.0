Return-Path: <linux-erofs+bounces-3492-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBCILn5BGmot2ggAu9opvQ
	(envelope-from <linux-erofs+bounces-3492-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 30 May 2026 03:46:38 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4EC60AD62
	for <lists+linux-erofs@lfdr.de>; Sat, 30 May 2026 03:46:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gS33v1W3cz2ySC;
	Sat, 30 May 2026 11:46:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::542" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780105595;
	cv=pass; b=TZtAO+M17kMFZUyTUgVpqEEyU6EQA1sjCmP7EFkdxxaSnNc9vy4plTTyP9TDxQaVEBs080FA0RJEBW8JnYNmszlWPku3tyMgRi66QjeDWNBZ5pYBrjHWSHTH5jnsvpd5bneVJf9LyukhG9KEEEEFEADv3TWivaLNAU25vZPwvtTT/UupAyfbx2pqTakPUVhFy/ZfiQzpsvIQS7IIOhspLCJRh72+6Vs2UErkCuX6B7Tka/gjCUeq1NE8Radwe8zges7KL7XQ6+QyT3oZR/7SuLHf8AwixP5PJC1jlrVLEuTgzEUhmbriEWnIrI1pzG0wbM/6GTd46JPo3o/h3G75Fw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780105595; c=relaxed/relaxed;
	bh=E1sLSRzJJUkH0W3tWVgjgtkRs5G8i5oJq5j/TLdnhhA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BANqGwG8KU/Pqo6xYBqivWXZkqbh7E/4NwtVZa+hHhbChMhaYtVRJReSGcUdcCxROdZrnkv2nZvpK7TM/p+J9VvhbwFRPSPTUBGkL5nnfiWHEfsAiytkK8IUHaUIz1CJnyY20diOVJ0NOULK2TTEOSrMI8DHRNs2Z+s+je1+uPTmyIyI2uW0HJxOK0JhePwSg8MuuWmjNZB/E15FgTBbPwy2dRTgrRMvTl8zNHBXtufDA5910C78bC4vX+lfVQIzks4/cFCVQhIYiEReEoJokQ3WFxTycYEE589XhzPRGMbWw7Dm6Uk8s3HkRQX+DNrIqkKK1VTERxNxk+TCiS+ROA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=by4/yj1g; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com; envelope-from=mizellikeksi@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=by4/yj1g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com; envelope-from=mizellikeksi@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gS33s25KJz2xLs
	for <linux-erofs@lists.ozlabs.org>; Sat, 30 May 2026 11:46:32 +1000 (AEST)
Received: by mail-ed1-x542.google.com with SMTP id 4fb4d7f45d1cf-6804e24803bso2720502a12.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 29 May 2026 18:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780105589; cv=none;
        d=google.com; s=arc-20240605;
        b=Fg4wqlfrlsZzJB7qlNc3Ts88kTE3iNVaXhuocJ8ohslZTpjB2N29EZQ+KA8G1+TsA2
         nP3efd6DWBaR1aEsK+m4Y7pY3fNC6EvUzIZ4zO8dXmBBZaH56dWvY3YMtE4p99xGYn6V
         r7ed3NBTfVntBwTCbMeKp/b2w1mFFbbE8IvUtayB+u9F6gCprApcSJARoTvxkBXdkw0k
         +xpwwMOGz6fDLxlJPDBAmOMm0sRY8bGpuLsf2LC5/dnS5R1sSPx0y7mWp8l5EL5PyLF6
         OYxGiMuzMhqFHOXTuFq4LK/3K+tq5GvsF+giNjVcsdmTR/JVP08DSY50ZUnukoxSb172
         aaqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=E1sLSRzJJUkH0W3tWVgjgtkRs5G8i5oJq5j/TLdnhhA=;
        fh=wOhGMmq2KH+KOElLlPuS8ws9o9ArjDb4wH58JVHh4Vg=;
        b=f2mpx3vJD0tNnGM6rRfu3PfXY9+UYO5Iyf8pftGR0//p03rbNo8j4P6p9mTrvA4FKo
         7fnEjZlVEI/4vd6bIVhaklilDnkZ3nzErTQtFq/i1bf5en8y0V/o6B1kepmHNc0elN6d
         GSvvK1ivQQr+SpjR3jI82EQN/JNoap4+MVCS6sbys/iwoypMNGrA78qrtvIbcIKC9JBm
         r+mZtuXZrPhEdcd+La56orBH2PH9Or/KJobWT9tYssTX9cXaCSn3I0hlPqeNaV1+OyQS
         YeEn0bbotuA755Qe0b7acI1aDxBT48l04CDhLK5KtyBQzOJJFeWxuWEZeHkKi+vhfDLl
         TV+Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780105589; x=1780710389; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E1sLSRzJJUkH0W3tWVgjgtkRs5G8i5oJq5j/TLdnhhA=;
        b=by4/yj1gegRE3tzLJ0Kdpy1ewPZf8a5hJ22eS7vAT6Z6NBhfy/HTIfDpY/NDGuEFxG
         qhgdAmwwGidkhYqzVFC9ywXzNw1zVSF7BqCCYdM5Erh+NH1ftUi5RZZMu6PRQKdDrG+1
         0A0DZYIjS6jSA+y5YnQwzd+yj9GXc3fUxG5iBDIQ9bf4uGzv35TgJm9QroVixGgj4cTL
         xMB0BYw26xhNQd7UBhI1mFiY4xiyeVtE00J4On0XNZvXujkXYlGX3SPwqTTMzIgFiwsL
         1Y5z5cnmpTkWCAU4E6ysxMbY6HjsOIhAHH8sbQF2Ilcy/CdHtLrPhHYTxieyJljRsnVZ
         nhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780105589; x=1780710389;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1sLSRzJJUkH0W3tWVgjgtkRs5G8i5oJq5j/TLdnhhA=;
        b=BBPBIz5qfTVyQbMqX569YaTO6ArXpZIBJnbZPrx6Vlh4mH1GkgkO6CkBNjGvAqGBqI
         pfHd72OIoaWflZ7cOyg5ybJrd2UIGOMb/03SOK5hYyKc7awbF9w5SPiG72WOQv/DMPzk
         1XgwHTePw+Nwiuo5VlhoPMyhRYFlVUd1ptxF1WMZLpzv4CDceba6pDa2+6+utL+0e4XT
         HTMkSBdPKpugsFcepbSvOJbJTHDr0L5WvLssSQVJyBhrB80o7ik/hukfKghX3zkLAV6R
         zOwmIeInZaBkKQAOhM6GrGQRd2b/z6SHnr7UGmPFduFUsxjw9OU1/sB17N3+yxIRAcEK
         Xxyw==
X-Gm-Message-State: AOJu0Yylql+4s3YrhT5xBdMJ8gL0BssXjaVuYlfiKbHAyuZE6TamspV2
	52/+TpKMDOjFcoW1v8KTcqFm1YtaYTldiP+oZRSKFve0cz7UmPwUYBd2I8YYrjOCgNMXC2Y1blf
	suYEOF0wDBqvmEZkzokW17H0b8FLIIppGxnkyLTIOXTbF
X-Gm-Gg: Acq92OHZ4rAMhWYm2KAF3fib5zZVy4uIBdfFzY6jWfKLnbt8JCYqWIdNZNzuClXrqea
	l9jB/rcv8G9SKmaXYRiIghXge2nU4rvyjZtHLlbe6U+9gPdsgfcETZHDc9bYGkuXGI26hZp7A5h
	H2GqaTqdLwMTAhYHiky+0gxuVWeynQoGmfM5k8Ou0g4LGVOKkVSvdIuhRYxBWeSYEi59dc2xGSe
	3l7elGiGxawBxMhZKN2Q/yfucpxvsn5/tuRl/22778BUjCo/opgBu0yAqPROSuwf52ahcU96W5D
	9ELSA4k+n5uogmEEB5ESqsLUZ5q6M3qVQCSuJ3/drJuB7mo5HiB7V6mNkP2vffilSuXhCtk4hKZ
	eKsrWVhl+VARZOPUWm43gqzVzdHuZbcpQ2/o9BL3MrNPZVR6zFU6YyPtvzl6Fcmb6QTmvxpjaKU
	GozSADIAdoWOpUV36OEv4MwWUG
X-Received: by 2002:a05:6402:354f:b0:68c:df5b:d6e7 with SMTP id
 4fb4d7f45d1cf-68cdf5bd85fmr106757a12.10.1780105588415; Fri, 29 May 2026
 18:46:28 -0700 (PDT)
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
From: Kelly Dang <mizellikeksi@gmail.com>
Date: Sat, 30 May 2026 08:46:16 +0700
X-Gm-Features: AVHnY4LiV8_bpP3wheSe1oOnHUZ5YrsElyPLud8mYRWT3-SgeANMi_vwWxuvT9o
Message-ID: <CADVYKHsxyZyMuQJRE_eXEiE9YDLhgb3G+wg+S_6SSuF3bDiSNA@mail.gmail.com>
Subject: =?UTF-8?B?6ZO26KGM5pyA5oCV5L2g55So4oCc6L+ZM+aLm+KAneWtmOmSsQ==?=
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="00000000000042a2140652ff2104"
X-Spam-Status: No, score=2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_DBL_SPAM
	autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.10 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3492-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mizellikeksi@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.761];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:rdns,lists.ozlabs.org:helo,mail.gmail.com:mid,sumo.ad:url]
X-Rspamd-Queue-Id: DD4EC60AD62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--00000000000042a2140652ff2104
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

KuS9oOWlvSEqDQoNCuWutuS6uuS7rO+8jOWtmOmSsei/meS6i+WEv+eci+i1t+adpeeugOWNle+8
jOWunuWImeaal+iXj+eOhOacuuOAgg0KDQrpk7booYzooajpnaLkuIrnrJHohLjnm7jov47vvIzl
hbblrp7mnIDmgJXlkrHmjozmj6Hov5kz5oub5a2Y6ZKx5rOV77yM55So5LqG6L+Z5Lqb5pa55rOV
77yM5Yip5oGv6IO95aSa5ou/5LiN5bCR77yM6KaB5piv6L+Y5LiN55+l6YGT77yM6YKj5Y+v5bCx
5LqP5aSn5LqG77yBDQoNCuS7peS4i+aYr+aWh+eroOeahOS4u+imgeWGheWuue+8mg0KDQpodHRw
czovL3N1bW8uYWQvemhlLTMtemhhby1jdW4tcWlhbjINCg0K5oSf6LCi5L2g6ZiF6K+76L+Z56+H
5paH56ug77yBDQoNCi0tLQ0KDQrmr4/kuIDku73nnJ/nkIbpg73lgLzlvpfooqvmjY3ljavvvIzm
r4/kuIDku73lhazmraPpg73lgLzlvpfooqvov73msYLjgIINCg==
--00000000000042a2140652ff2104
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PHAgc3R5bGU9ImNvbG9yOnJnYigwLDAsMCk7Zm9udC1mYW1pbHk6JnF1
b3Q7VGltZXMgTmV3IFJvbWFuJnF1b3Q7O2ZvbnQtc2l6ZTptZWRpdW0iPjxzcGFuIGNsYXNzPSJn
bWFpbC1hdXRvLXN0eWxlMSIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhl
aSZxdW90OyI+PHN0cm9uZz7kvaDlpb0hPC9zdHJvbmc+PC9zcGFuPjxiciBjbGFzcz0iZ21haWwt
YXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVv
dDsiPjxiciBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVv
dDtNaWNyb3NvZnQgWWFIZWkmcXVvdDsiPjxzcGFuIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMSIg
c3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90OyI+5a625Lq65Lus
77yM5a2Y6ZKx6L+Z5LqL5YS/55yL6LW35p2l566A5Y2V77yM5a6e5YiZ5pqX6JeP546E5py644CC
PC9zcGFuPjxiciBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTom
cXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDsiPjxiciBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEi
IHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDsiPjxzcGFuIGNs
YXNzPSJnbWFpbC1hdXRvLXN0eWxlMSIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29m
dCBZYUhlaSZxdW90OyI+6ZO26KGM6KGo6Z2i5LiK56yR6IS455u46L+O77yM5YW25a6e5pyA5oCV
5ZKx5o6M5o+h6L+ZM+aLm+WtmOmSseazle+8jOeUqOS6hui/meS6m+aWueazle+8jOWIqeaBr+iD
veWkmuaLv+S4jeWwke+8jOimgeaYr+i/mOS4jeefpemBk++8jOmCo+WPr+WwseS6j+Wkp+S6hu+8
gTwvc3Bhbj48YnIgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9udC1mYW1pbHk6
JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7Ij48YnIgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUx
IiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7Ij48c3BhbiBj
bGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3Nv
ZnQgWWFIZWkmcXVvdDsiPuS7peS4i+aYr+aWh+eroOeahOS4u+imgeWGheWuue+8mjwvc3Bhbj48
YnIgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7TWlj
cm9zb2Z0IFlhSGVpJnF1b3Q7Ij48YnIgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0i
Zm9udC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7Ij48c3BhbiBjbGFzcz0iZ21h
aWwtYXV0by1zdHlsZTEiPjxzcGFuIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlMyIgc3R5bGU9ImZv
bnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90OyI+PGEgaHJlZj0iaHR0cHM6Ly9z
dW1vLmFkL3poZS0zLXpoYW8tY3VuLXFpYW4yIj5odHRwczovL3N1bW8uYWQvemhlLTMtemhhby1j
dW4tcWlhbjI8L2E+PC9zcGFuPjwvc3Bhbj48L3A+PHAgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUx
IiBzdHlsZT0iY29sb3I6cmdiKDAsMCwwKTtmb250LXNpemU6bWVkaXVtO2ZvbnQtZmFtaWx5OiZx
dW90O01pY3Jvc29mdCBZYUhlaSZxdW90OyI+5oSf6LCi5L2g6ZiF6K+76L+Z56+H5paH56ug77yB
PC9wPjxwIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxlOSIgc3R5bGU9ImZvbnQtc2l6ZToxMS41cHQ7
Y29sb3I6cmdiKDkxLDEwMiwxMTYpIj4tLS08L3A+PHAgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUx
NCIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90Oztjb2xvcjpy
Z2IoMCwxMjMsMjU1KTtmb250LXNpemU6bWVkaXVtIj7mr4/kuIDku73nnJ/nkIbpg73lgLzlvpfo
oqvmjY3ljavvvIzmr4/kuIDku73lhazmraPpg73lgLzlvpfooqvov73msYLjgII8L3A+PC9kaXY+
DQo=
--00000000000042a2140652ff2104--

