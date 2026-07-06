Return-Path: <linux-erofs+bounces-3819-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3cMjFB0XS2o8LwEAu9opvQ
	(envelope-from <linux-erofs+bounces-3819-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 06 Jul 2026 04:46:53 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ADC70C340
	for <lists+linux-erofs@lfdr.de>; Mon, 06 Jul 2026 04:46:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=A7m7Pd6M;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3819-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3819-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=2")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtpTx25Knz2yfS;
	Mon, 06 Jul 2026 12:39:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783305573;
	cv=pass; b=Dh+xZemuCruH6JkWLsLVsFJMj/s20V6kIT/VZQeKH8RdeTytQzxyne2oTb1O4/ulm5/uPLGoOPSH+DbC6OtjMySN7UaS6nTHD4kkN2mFXv4NO684wk3h9s4xLs8te0LGg6zkZRLV2B2Qsp8Q+vqJ4mTPufBWUdfCTdL9Pwm3KO7C8JX4z9G0gr8+OpUwPA2IkhCXwWrbLJ0E5PDDAJsRKnzPa1Cie6geN/p3Y3TG+VDqur9di7Tx/UtWbMqYNrde5B7t/MNlgHeC6ApNAlV17FiXdmuCENkZlbmQA9ha4uN7cjf/HEKoFFe5CpWk18bXtjZgG1XZWJy1BRJmHaNV0w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783305573; c=relaxed/relaxed;
	bh=w/9MvatahMl6JeEhJ2VVbIiQr/n2HHMjyJxuGc15yPQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=iamwhfuk76UjUqg8ckUr1Py/dB4kPDyfcPndyzBBUD+SCOZ0LCjLMR7kebeXd06epLoCqbNsd9QJBToPBlJL2Nhg9xc1f9SnuDmYtbMuTUUQkE/EEKpR0EHJFmA1LA2FxnA+mALmjhxYLxUTbctfsemacT5iM8kZevUFYJKwsEww1pznBn4IrkWf2UesvBhTmwMPFeJOxlZIMBCP40Ia7OSZJoZ7QUmu7Qai6dEvWPwyhcKHyWum3wIXipGHQykWmAvzkenin/bApaiERjQEMhbZa69MQ+1mVf60X9q7ytfa6WKmt473/8OCwV9SY82meWoNoYVIG9Yjz4/Jo5qCNw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A7m7Pd6M; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=mh.0555530921@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtpTt6G7Bz2yVZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 06 Jul 2026 12:39:29 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-847aebc56b6so1838047b3a.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 05 Jul 2026 19:39:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783305567; cv=none;
        d=google.com; s=arc-20260327;
        b=kh3HxK8lIszPL52dLt/FsnccHmoNHAoVDPWicAE9vkSg12jLDI1WRRbHDV74Umk9sq
         VXWPpCQn03LyNz2K1Y+qjA8PzD1FT0i3RXTMLU06i0Sf3gQ2TPu/ldTE99XWGmWwCqaR
         hxdJZzKJjIgizn0fyTDF/QAJ3AmD/nZAJ6THB5KeL/ksUOGaNWg4fYQYZL+tHWni58N6
         tE4J2Mpo8ayTe47k52Li8C9t4hVXdmExvZ4jXYNfjaaOxysX1WvyGuScz9Hc8m0ewiqt
         ehBFOUCA+AJ/Bm/OkE0cviyJiGHkVTk1QXlEocvTTuDMRZRpk/02xkK1E7N9OiPTk+oQ
         pzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=w/9MvatahMl6JeEhJ2VVbIiQr/n2HHMjyJxuGc15yPQ=;
        fh=QNUuacWW6qRR5Ne4Dd6riqB5Oa4m0tykLcnO/0yA1Fk=;
        b=I1jFus5AvyW3cRJtJIgatDU+se8J/Il6878a+V5QY8gZKp6p8dzhBob2xgaIA784Ig
         L3xcw3gZBLzpVrhhzf6LA3fDR2SE4WvtvqdvD0LA0SMMpdoJNrZklDg97PrqAUPVRE4d
         aIGUEL3boeHuNT5PpX7G9X40PH2X68LexO1+hGZtJsizgSvHCdp/s8lhCPKbpWdvlIla
         ddgwsWmKoSTH31t5BDacELjJUnBhBat5nnxPJKnN5jMP5EouJsROs83RRrVFGLh585Ww
         liRwB7CnMcKikzQHC/x5M9QDRYLxNxMLldcVLPpHAwT0ARQ8AToaZKyCAgNaMA0JICJC
         nUFg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783305567; x=1783910367; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w/9MvatahMl6JeEhJ2VVbIiQr/n2HHMjyJxuGc15yPQ=;
        b=A7m7Pd6MkQ4D9I3VGtoD537Qg+KvazGFZwH1RQcYvpww2suor6NgI/EiD2sww7SoyT
         aTP99M5OpIye280VkFhaLx6pGeCFDq32V3QaB+KVEzN+qV3D3eE49pRvm8cwqHB1YT3w
         V4wqqd34oz/L5GPctW5miQMFpxtd2okHm6uw1TSyBAgBLQYhE+Ucm7n6vHjRLg9bXXui
         ZqpxmPHCj44BJ53devOTA63TPqrN4RW6MbZJ9ELmeuq0ZNcblTqg51wbyRiIQudRpiig
         ZOPqZr7soDKIH90ADfLgIOxZoQYlpGRAq7Mw+YwwrEHd9Rbe0xuglZNl9nsDcKN9flYG
         US1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783305567; x=1783910367;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/9MvatahMl6JeEhJ2VVbIiQr/n2HHMjyJxuGc15yPQ=;
        b=Wc/aBsm7O6j8kFnP+dz7nqND0c3qYlKhmPchjAA9wnpdica6FgGs4SAPtzq5dAqSIP
         SlAC9VlD7PXhChLwWttevnV8xzrffvChYnu3lR4nyAIT/ekR0wr4qPE1iRPU3utnHP2I
         6Acg06JJDTn2/vo98LImr/EDvCetHZ/DEcNnFjT0shT5/iQFO/5L8cPGEOLiFy2pV4uN
         pd6GVkIbDaC/mYzoH+LS5WfhFyNsB5dJLg2f7TOfKt3zys6kDnMKIGSPcHreD1nBfyNa
         B8MJ10s2/6D9HhxTqrwx/ad/xietxPUihh9bpytBcZMM3qfTiEkl26DLv+xj/e/56XOD
         7vMQ==
X-Forwarded-Encrypted: i=1; AHgh+RqUmaobwydlFvRyKpiCNf5yAXPkFCGVSCJb8lpryY3p8be0A2Y6V6s8zJAQnhGmy79d1fBKfaJqvG03NQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxxI0ydFmpuFPdc7yZQ2jXzXV2HYaaOjhJWdxYKH/PsFxIw8zJn
	SqIPr2GtlAljYJ6H2XmP3UIMtBm1OLVbSKaqbofOQ2nilWNLbuNTqjALkpCagKHGZHd9eLoxXcI
	CTt/qzaT0puGpE91MKd0BvTF/flhoZIg=
X-Gm-Gg: AfdE7cnlE/YNKzKzr5VjAmjZuWDr1eFI8Hu46efStaundNiLxofj3V2IDqKMdt312ED
	zrCFmdMHPVb8paWrH+jW8hXfEGseRNgNHb00OqWHDrwPNiQGVU1zyJq4rXLpOAG4DCqZCZb1BhL
	3NV6oeKDskAOhs3z7+OXc+vQbFE0SLa55r9JktOwD1J5FB5R3ZSr8Iu22k8hbWTfP5JcwkxLPbp
	XWpPKeAHvvpHiz1tGdk+e3maFIEKP3yakkAOBVqpb5dImIYGeLZuD/7tqsqQnAM+RHauSQn0WLI
	0SLSD+ysT/Qfsl7RU99v7M4TAKbPSHwuLDsSzObUvDC8ixturBOIJHoZvHJZr/FKt0UKckZilSl
	KW8bMaBlF99xRaWktemTOHc/j+D5ab1Tem5ea7t9Wufd8T5mPKmU0IBEKfq4ESRT9KULoKnN3QD
	R6yOnymYTKoFH1fXf5Fl8o2U9VYXhEPPz59BiiZZV3AKDRHABOd5MvizvKc01z7j/mUZjYNJFmH
	sFMjiI=
X-Received: by 2002:a05:6a21:1b84:b0:3bf:6c04:a819 with SMTP id
 adf61e73a8af0-3c03e4e08ffmr8275376637.58.1783305566777; Sun, 05 Jul 2026
 19:39:26 -0700 (PDT)
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
From: Monica Chen <mh.0555530921@gmail.com>
Date: Mon, 6 Jul 2026 09:39:15 +0700
X-Gm-Features: AVVi8CeF7XMvRmEKF6nu4ee4uhzfnH9h_U2Hul61EbPLaSL56Nn6vNExxMfD99Y
Message-ID: <CANCHSnqCrPApCuT+6Lr+7tSs9DLVXG1=dyqLQn70cR5Qrxkr-g@mail.gmail.com>
Subject: =?UTF-8?B?5Li65LuA5LmI6auY5rK56auY55uQ5a+56KGA566h5Lyk5a6z6L+Z5LmI5aSn77yf?=
To: 2534760384@qq.com, deepag@saveetha.com, linux-erofs@lists.ozlabs.org, 
	soz.ethik@kaththeol.lmu.de, inaba@uchc.edu
Content-Type: multipart/alternative; boundary="000000000000d574990655e82eab"
X-Spam-Status: No, score=2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	HTML_MESSAGE,SPF_HELO_NONE,SPF_PASS,URIBL_DBL_SPAM autolearn=disabled
	version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.10 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:2534760384@qq.com,m:deepag@saveetha.com,m:linux-erofs@lists.ozlabs.org,m:soz.ethik@kaththeol.lmu.de,m:inaba@uchc.edu,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[qq.com,saveetha.com,lists.ozlabs.org,kaththeol.lmu.de,uchc.edu];
	FORGED_SENDER(0.00)[mh0555530921@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-3819-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mh0555530921@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:from_smtp,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,mail.gmail.com:mid,sumo.ad:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67ADC70C340

--000000000000d574990655e82eab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

KuS9oOWlvSEqDQoNCjIwMjPlubTjgIrmrKfmtLLlv4PohI/mnYLlv5flvIDmlL7niYjjgIvliIrl
j5HnmoTkuIDpobnlpKflnovnoJTnqbblj5HnjrDvvJrpq5jnm5DmkYTlhaXmmK/liqjohInnoazl
jJbnmoTkuIDkuKrph43opoHlm6DntKDvvIznm5DlkIPlvpflpKrlpJrkuI7liqjohInnoazljJbm
mL7okZfnm7jlhbMNCg0KMS4g6auY55uQ77ya5Yqg6YCf6KGA566h56Gs5YyWDQoyLiDpq5jmsrnv
vJrlr7zoh7TooYDnrqHnoazljJYNCg0K5aaC5L2V6YCa6L+H5pel5bi46aWu6aOf6aKE6Ziy6KGA
566h56Gs5YyW77yfIOS7peS4i+aYryDpooTpmLLooYDnrqHnoazljJbvvIzml6XluLjppa7po5/n
moQxMuS4qumHjeeCuQ0KDQoxLiDogonnsbvvvJropoHpgILph4/lnLDlkIMNCjIuIOm4oeibi++8
muavj+WkqeWQgzHkuKoNCjMuIOmxvO+8muavj+WRqDMwMC02MDDlhYsNCjQuIOWltuWItuWTge+8
muavj+WkqeS4gOadr+eJm+Wltg0KNS4g6LGG57G777ya5q+P5ZGo5LiN6LaFNzIw5YWLDQoNCi4u
Lg0KDQrngrnlh7vmn6XnnIvmm7TlpJrvvIzkuI3opoHplJnov4fku7vkvZXph43opoHkv6Hmga/v
vIENCg0KaHR0cHM6Ly9zdW1vLmFkL3dlaXNoZW1lLWdhb3lvdS1nYW95YW4tZHVpLXhpZWd1YW41
DQoNCuelneS9oOS4gOWIh+mDveWlve+8gQ0KDQotLS0NCg0K5Lq65b+D5ZCR5ZaE77yM5pyq5p2l
5Y+v5pyfDQo=
--000000000000d574990655e82eab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"gmail-auto-style1" style=3D"font-size:medium;f=
ont-family:&quot;Microsoft YaHei&quot;;color:rgb(0,0,0)"><strong>=E4=BD=A0=
=E5=A5=BD!</strong></p><p style=3D"color:rgb(0,0,0);font-family:&quot;Times=
 New Roman&quot;;font-size:medium"><span class=3D"gmail-auto-style1" style=
=3D"font-family:&quot;Microsoft YaHei&quot;">2023=E5=B9=B4=E3=80=8A=E6=AC=
=A7=E6=B4=B2=E5=BF=83=E8=84=8F=E6=9D=82=E5=BF=97=E5=BC=80=E6=94=BE=E7=89=88=
=E3=80=8B=E5=88=8A=E5=8F=91=E7=9A=84=E4=B8=80=E9=A1=B9=E5=A4=A7=E5=9E=8B=E7=
=A0=94=E7=A9=B6=E5=8F=91=E7=8E=B0=EF=BC=9A=E9=AB=98=E7=9B=90=E6=91=84=E5=85=
=A5=E6=98=AF=E5=8A=A8=E8=84=89=E7=A1=AC=E5=8C=96=E7=9A=84=E4=B8=80=E4=B8=AA=
=E9=87=8D=E8=A6=81=E5=9B=A0=E7=B4=A0=EF=BC=8C=E7=9B=90=E5=90=83=E5=BE=97=E5=
=A4=AA=E5=A4=9A=E4=B8=8E=E5=8A=A8=E8=84=89=E7=A1=AC=E5=8C=96=E6=98=BE=E8=91=
=97=E7=9B=B8=E5=85=B3</span><br class=3D"gmail-auto-style1" style=3D"font-f=
amily:&quot;Microsoft YaHei&quot;"><br class=3D"gmail-auto-style1" style=3D=
"font-family:&quot;Microsoft YaHei&quot;"><span class=3D"gmail-auto-style1"=
 style=3D"font-family:&quot;Microsoft YaHei&quot;">1. =E9=AB=98=E7=9B=90=EF=
=BC=9A=E5=8A=A0=E9=80=9F=E8=A1=80=E7=AE=A1=E7=A1=AC=E5=8C=96</span><br clas=
s=3D"gmail-auto-style1" style=3D"font-family:&quot;Microsoft YaHei&quot;"><=
span class=3D"gmail-auto-style1" style=3D"font-family:&quot;Microsoft YaHei=
&quot;">2. =E9=AB=98=E6=B2=B9=EF=BC=9A=E5=AF=BC=E8=87=B4=E8=A1=80=E7=AE=A1=
=E7=A1=AC=E5=8C=96</span><br class=3D"gmail-auto-style1" style=3D"font-fami=
ly:&quot;Microsoft YaHei&quot;"><br class=3D"gmail-auto-style1" style=3D"fo=
nt-family:&quot;Microsoft YaHei&quot;"><span class=3D"gmail-auto-style1" st=
yle=3D"font-family:&quot;Microsoft YaHei&quot;">=E5=A6=82=E4=BD=95=E9=80=9A=
=E8=BF=87=E6=97=A5=E5=B8=B8=E9=A5=AE=E9=A3=9F=E9=A2=84=E9=98=B2=E8=A1=80=E7=
=AE=A1=E7=A1=AC=E5=8C=96=EF=BC=9F =E4=BB=A5=E4=B8=8B=E6=98=AF =E9=A2=84=E9=
=98=B2=E8=A1=80=E7=AE=A1=E7=A1=AC=E5=8C=96=EF=BC=8C=E6=97=A5=E5=B8=B8=E9=A5=
=AE=E9=A3=9F=E7=9A=8412=E4=B8=AA=E9=87=8D=E7=82=B9</span><br class=3D"gmail=
-auto-style1" style=3D"font-family:&quot;Microsoft YaHei&quot;"><br class=
=3D"gmail-auto-style1" style=3D"font-family:&quot;Microsoft YaHei&quot;"><s=
pan class=3D"gmail-auto-style1" style=3D"font-family:&quot;Microsoft YaHei&=
quot;">1. =E8=82=89=E7=B1=BB=EF=BC=9A=E8=A6=81=E9=80=82=E9=87=8F=E5=9C=B0=
=E5=90=83</span><br class=3D"gmail-auto-style1" style=3D"font-family:&quot;=
Microsoft YaHei&quot;"><span class=3D"gmail-auto-style1" style=3D"font-fami=
ly:&quot;Microsoft YaHei&quot;">2. =E9=B8=A1=E8=9B=8B=EF=BC=9A=E6=AF=8F=E5=
=A4=A9=E5=90=831=E4=B8=AA</span><br class=3D"gmail-auto-style1" style=3D"fo=
nt-family:&quot;Microsoft YaHei&quot;"><span class=3D"gmail-auto-style1" st=
yle=3D"font-family:&quot;Microsoft YaHei&quot;">3. =E9=B1=BC=EF=BC=9A=E6=AF=
=8F=E5=91=A8300-600=E5=85=8B</span><br class=3D"gmail-auto-style1" style=3D=
"font-family:&quot;Microsoft YaHei&quot;"><span class=3D"gmail-auto-style1"=
 style=3D"font-family:&quot;Microsoft YaHei&quot;">4. =E5=A5=B6=E5=88=B6=E5=
=93=81=EF=BC=9A=E6=AF=8F=E5=A4=A9=E4=B8=80=E6=9D=AF=E7=89=9B=E5=A5=B6</span=
><br class=3D"gmail-auto-style1" style=3D"font-family:&quot;Microsoft YaHei=
&quot;"><span class=3D"gmail-auto-style1" style=3D"font-family:&quot;Micros=
oft YaHei&quot;">5. =E8=B1=86=E7=B1=BB=EF=BC=9A=E6=AF=8F=E5=91=A8=E4=B8=8D=
=E8=B6=85720=E5=85=8B</span><br class=3D"gmail-auto-style1" style=3D"font-f=
amily:&quot;Microsoft YaHei&quot;"><br class=3D"gmail-auto-style1" style=3D=
"font-family:&quot;Microsoft YaHei&quot;"><span class=3D"gmail-auto-style1"=
 style=3D"font-family:&quot;Microsoft YaHei&quot;">...</span><br class=3D"g=
mail-auto-style1" style=3D"font-family:&quot;Microsoft YaHei&quot;"><br cla=
ss=3D"gmail-auto-style1" style=3D"font-family:&quot;Microsoft YaHei&quot;">=
<span class=3D"gmail-auto-style1" style=3D"font-family:&quot;Microsoft YaHe=
i&quot;">=E7=82=B9=E5=87=BB=E6=9F=A5=E7=9C=8B=E6=9B=B4=E5=A4=9A=EF=BC=8C=E4=
=B8=8D=E8=A6=81=E9=94=99=E8=BF=87=E4=BB=BB=E4=BD=95=E9=87=8D=E8=A6=81=E4=BF=
=A1=E6=81=AF=EF=BC=81</span><br class=3D"gmail-auto-style1" style=3D"font-f=
amily:&quot;Microsoft YaHei&quot;"><br class=3D"gmail-auto-style1" style=3D=
"font-family:&quot;Microsoft YaHei&quot;"><span class=3D"gmail-auto-style2"=
 style=3D"font-family:&quot;Microsoft YaHei&quot;"><a href=3D"https://sumo.=
ad/weisheme-gaoyou-gaoyan-dui-xieguan5" target=3D"_blank">https://sumo.ad/w=
eisheme-gaoyou-gaoyan-dui-xieguan5</a></span></p><p style=3D"color:rgb(0,0,=
0);font-family:&quot;Times New Roman&quot;;font-size:medium"><span class=3D=
"gmail-auto-style1" style=3D"font-family:&quot;Microsoft YaHei&quot;">=E7=
=A5=9D=E4=BD=A0=E4=B8=80=E5=88=87=E9=83=BD=E5=A5=BD=EF=BC=81</span></p><p c=
lass=3D"gmail-auto-style9" style=3D"font-size:11.5pt;color:rgb(91,102,116)"=
>---</p><p style=3D"color:rgb(0,0,0);font-family:&quot;Times New Roman&quot=
;;font-size:medium"><span class=3D"gmail-auto-style1" style=3D"font-family:=
&quot;Microsoft YaHei&quot;"></span></p><p class=3D"gmail-auto-style14" sty=
le=3D"font-family:&quot;Microsoft YaHei&quot;;color:rgb(0,123,255);font-siz=
e:medium">=E4=BA=BA=E5=BF=83=E5=90=91=E5=96=84=EF=BC=8C=E6=9C=AA=E6=9D=A5=
=E5=8F=AF=E6=9C=9F</p></div>

--000000000000d574990655e82eab--

