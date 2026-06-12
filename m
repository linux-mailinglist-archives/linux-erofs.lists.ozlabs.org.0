Return-Path: <linux-erofs+bounces-3576-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xKGeIw+pK2pQBgQAu9opvQ
	(envelope-from <linux-erofs+bounces-3576-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jun 2026 08:37:03 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F413676F68
	for <lists+linux-erofs@lfdr.de>; Fri, 12 Jun 2026 08:37:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=b3KqIhjq;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3576-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3576-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=2")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gc8v01KQDz3brt;
	Fri, 12 Jun 2026 16:37:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781246220;
	cv=pass; b=mXvTf+uKSRi3OXrxfjcysCKB9BdQ7MqiOiPa6cbzrCOgR1BAPMip5ytItKo5KpeXvWa+zj9//rl0yy005aak/+ptonUGvvRs75e1FbBrzTdTh4LbR61onEZwpvuUYFD79HHpfB02TNrIZrS1nHkozsMBm0tdwl8dP303DCXrbAT7DnIBbWcj2ue4r2DeNWjkvJTeC/WthH3h+Pq0OlfhqRshSSrGtx0SGJAi8PaugtqudFePMVV0FUHXBI/X/4nardJi2/NVyv2XkZfnJIRoaesbLSbHdsts/lwsob61tQawF+XP6Lifzdfogq2YuS20UiwnSMUxqu2cTiGDAS2nTw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781246220; c=relaxed/relaxed;
	bh=8pHbJrAmEddjaVICUZsITrmQ713qp2yaXURLQalqQFc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kck+ZOQZYMc6HHE3/dG3d8WMylSEUGdn/NJUnlah8NPx1dT8vbEiWH6dluy9US3YNhz8WA7tyezqIrYS32kYyUu/AAjL5HPEOAyGxz6aE/jzurL3I80gVUQ8jLdbXFx2luM4v4FodJAO5/HT10ntzx1XKsJM23PwwXW++W0xa05G8kBqnSlhTTK90sqU93fPbe+XtuSCGHhuQaNSMrjj7ypsq1hkGKndnX17I5tDcF7lxOpx4lMZDxobJI3d8q8TZ/5vNsW+clYIrSzyCW3OMheOBM/bRl0u8J93Q15gJnqk1S3sWdyKc39dbnWLTlhe+Iu2Z2GGsfaj+zQo1U35bw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b3KqIhjq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b143; helo=mail-yx1-xb143.google.com; envelope-from=meperlunch@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-yx1-xb143.google.com (mail-yx1-xb143.google.com [IPv6:2607:f8b0:4864:20::b143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gc8ty5mg7z2xmX
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 Jun 2026 16:36:58 +1000 (AEST)
Received: by mail-yx1-xb143.google.com with SMTP id 956f58d0204a3-660512d80b4so688340d50.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 11 Jun 2026 23:36:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781246215; cv=none;
        d=google.com; s=arc-20240605;
        b=OBAcj31yGZV6VctknAGNe0rY2l1eArRh2eYw2fkuupxsyvRVbL/Cf063KuOsgrkkWb
         W17sepPzeqeN6cH27sJqsGklC1rjbbI/bWvqlLsLW/qRvSWshWSQ1DWrZ/GEf5TBYO0V
         V1pJEDpJD5NctIcz0StwIUM+0tpXB87oiOh8f9UMhuWzmY6BaygLB3mvurFLmyVl7c3s
         es3IJO+ZR+pDkjpMgMXY1kDd7hvuG+7mm4CiL1/FFKLWUShEHapCPbCR7WwvZwKCmGkw
         okMLmhdGzwEBde3zHu5gBuEH/juNjvqhjhiTK2KKupen24yMcoqUVHJ91hs+ATCmqKKi
         ukpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=8pHbJrAmEddjaVICUZsITrmQ713qp2yaXURLQalqQFc=;
        fh=deW70JVB6o88YhJzf5ksMfLiL+7vsTKJV18pjO6fBaQ=;
        b=Wv06iqVPvrLz1sXh9lnP+MnvX8zCuKX4rXcfEe4gkJvRDpP6yYbxZm4ud/nPNhvK+d
         IUlitvA8Dk6m6GpzeOPgFdjwMIdXDeycOnX0XZf28cbD8ldkD8n14u3gMTKGm5n/hRE1
         vZCHLXz+/N/N9P9JJKMJtFYNWg2j3U6YqF6AejNYrQrJRWM0UTRzUhA+w1ll9qJx1wo9
         YOeNf0kb2rXDQPDLfJqkjURa1LcxtKlSTMZABPB8hlypSF5Cu/u+RDNal6GqiV+4JGnC
         NfQezlHgpUEvZ+WBnSsrcjeZRlPHnRveP37CqntAo9K3tCDC6Gl/xIPaPRIjXSB5TfmB
         qgEg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781246215; x=1781851015; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8pHbJrAmEddjaVICUZsITrmQ713qp2yaXURLQalqQFc=;
        b=b3KqIhjqUwJqcqNB0BOQTQ3lXiEcuuDtyhoXvEkTJcEDl2pNv9FPqQJ0/6yxtpaC0c
         QUpFua+tO7u642aCqx4ZheCAfMT9XZvwsDoBtXFsY6eisB7FT8z8KBOEb+tNmcVLrT3M
         K7zC+Ko7MhU312c/jeKQZku/xMF7pxv3umkU2h/uSmbwvbfMAgmea+rIn7d0Dhs7VTdg
         11MvrYQxIa76oXYwCNIF7Qe5IZvmBX4+R06wyLCwDDspOoaFWEnuWwQrkrheupg0yNmq
         HTjEI93gmTLsoD3zydCyQC9/BXNLviFSR2uw8h69n6P3J9yuTPaVbAc4Hf0xjrLXaXhm
         Vfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781246215; x=1781851015;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8pHbJrAmEddjaVICUZsITrmQ713qp2yaXURLQalqQFc=;
        b=O73DpQmIjVzeoFLklyUBnBC3+dCTpsQaSMZB9mSTs9x/bYhI8T655sWzrg2AR0qubr
         /AgSNxHPJEPElnz+FuVL4arG0oFciJ/BFw7uAwhRP9OFy4oa6Aa4NlI4lRQgEs95Y1SB
         NgyOmIrRqV0+DxcPH4K+qew9MGMuUsHsgqvLgJ3qHhENZh00z9yiEtg0tPoayyEn1GdN
         9oBByZvxT3Hto/j0oFsXeCCJdTMjTMbF794eNDIoQZws9PCdIV6VQKbUiYyoIbIqobWL
         ukhduytc8NprHbdRDbOTR5jXVMofPrtLSrmpg9jyrEJYPkQUC7yVyGgd4lacJ1jOvnSL
         3VHQ==
X-Forwarded-Encrypted: i=1; AFNElJ+MyEUsrQtS+L444lfQiMeswJ5cnnZ9fvWZJGOhAq1ZB6EY5fhM4lDk6F5mtLlT5yIKr3d0MHUboAJRSw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz5fGE1e7p5idQcloJ1n4UZESvjh0RjZorrDSnIRiqSAQG8d/XF
	FvB8n6p087NC8uq6CQ68suBbhfi353Y9Y5dNbXvC7q62YPVBXpxaQdGG9IS7f0zGbidAtvw5rXS
	mCBbvasu1UGTv+BNUgUt+izRDs1ywITU=
X-Gm-Gg: Acq92OHgfoSfzN2R7iq01Ld4QbwNnuzH3KaBnm3XGdhbF9DUSW6aQcjcIAJhhaBM9PZ
	pDDmUkTmire2u3CKJH9IgYKWFsV33SMG61lnYNX56s418jrPIlIJlcf62rmuL4rDunAr5895z19
	F3fg7aE8Hle/QO0g49n7f5UZMgD6a145aIsbXGVYT/059E0umyWvjLTEG6Hx/uOU0SOPUy8ovMk
	PgZgQc8ijqB7Y91Sz6bxseEtugAo44kIeWroSGWn8S83d5aEI6JGMh6EObgii5fWlDl5vpw17kr
	k2HElw7RUEqIH0OUNk++KaqLoKFBp49fbLgVJUJTyAsSRmOJ8bRhxCz+rMsrpyOuvzYfQbCLPTY
	CC4Z5oySUVaDi4B19jcoxaMaNayBVP2qYwEP79OKKFIssM1wiZmchFE9JmKp3ZlTKTlZKUqhY4U
	tkh9DLT5psiJ9/7ZhPnYng0AGCa28dgCrulxGGSFMHyc4Fqd3gNbYL9xJWPV8mTe7XUCpmwDaX9
	mB1iu45+G4IuHbyEEdMjKmCXsuMBDbFhVY=
X-Received: by 2002:a05:690e:144b:b0:660:e9fe:18e9 with SMTP id
 956f58d0204a3-66276aff4admr1308634d50.38.1781246215614; Thu, 11 Jun 2026
 23:36:55 -0700 (PDT)
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
From: Julianna Phung <meperlunch@gmail.com>
Date: Fri, 12 Jun 2026 13:36:44 +0700
X-Gm-Features: AVVi8CfGSHTjJFiIKg5CwqnbmuJbSf6ijVnPJHQdRJKyUU7Ih_62YwJaSFAz1cQ
Message-ID: <CAAUfmt6BxJ60wsPsm0O7N6BxUEm4ZfURmriaBAT7PNEkjU5XkA@mail.gmail.com>
Subject: =?UTF-8?B?6ZW/5a+/55qE5Lq65ZCD5LuA5LmI77yf6JCl5YW75biI55qE5Y6o5oi/5b+F5aSH6L+ZOA==?=
	=?UTF-8?B?56eN6aOf54mp?=
To: lacqzh@zafu.edu.cn, linux-erofs@lists.ozlabs.org, byndxwb@163.com
Content-Type: multipart/alternative; boundary="000000000000f075dc065408b3fa"
X-Spam-Status: No, score=2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_DBL_SPAM
	autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.10 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3576-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:lacqzh@zafu.edu.cn,m:linux-erofs@lists.ozlabs.org,m:byndxwb@163.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[zafu.edu.cn,lists.ozlabs.org,163.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[meperlunch@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meperlunch@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sumo.ad:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F413676F68

--000000000000f075dc065408b3fa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

KuS9oOWlvSEqDQoNCuaXpeacrOacieKAnOmVv+Wvv+S5i+S5oeKAneeahOensOiqieOAgiDlnKjl
pYjoia/plb/lpKfnmoTokKXlhbvluIjlr4zlhojnvo7mmbrlrZDnoJTnqbbplb/lr7/nmoTlgaXl
urfppa7po5/vvIzlpbnnu4/luLjlnKhDTkJD5LiK5pKw5paH5YiG5Lqr5pel5pys6aWu6aOf5Lmg
5oOv44CCDQoNCuWlueihqOekuu+8jOS4uuS6hua0u+W+l+abtOmVv+Wvv+OAgeabtOW/q+S5kO+8
jOWlueWutueahOWOqOaIv+W/heWkhzjnp43po5/nianvvIzogIzkuJTmr4/lpKnpg73lkIPjgILp
gqPkuYjov5kgOCDnp43po5/nianmmK/ku4DkuYjlkaLvvJ8NCg0KMS4g5oq56Iy2DQoyLiDlj5Hp
hbXpo5/lk4ENCjMuIOa1t+iXuw0KNC4g6LGG57G7DQo1LiDosYbohZAuLi4NCg0K6L+Y5pyJ5pu0
5aSaDQoNCuS7peS4i+aYr+aWh+eroOeahOS4u+imgeWGheWuue+8mg0KDQpodHRwczovL3N1bW8u
YWQvY2hhbmdzaG91LXJlbi1jaGktc2hlbm1lNw0KDQoNCg0K56Wd5L2g5LiA5YiH6YO95aW977yB
DQoNCi0tLQ0KDQrov73lr7vnnJ/nm7jvvIzmmK/lr7noia/nn6XmnIDlpb3nmoTlsIrph40NCg==
--000000000000f075dc065408b3fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p style=3D"color:rgb(0,0,0);font-family:&quot;Times New R=
oman&quot;;font-size:medium"><strong><span class=3D"gmail-auto-style2" styl=
e=3D"font-family:&quot;Microsoft YaHei&quot;">=E4=BD=A0=E5=A5=BD!</span></s=
trong><br class=3D"gmail-auto-style2" style=3D"font-family:&quot;Microsoft =
YaHei&quot;"></p><p class=3D"gmail-auto-style2" style=3D"font-family:&quot;=
Microsoft YaHei&quot;;font-size:medium;color:rgb(0,0,0)">=E6=97=A5=E6=9C=AC=
=E6=9C=89=E2=80=9C=E9=95=BF=E5=AF=BF=E4=B9=8B=E4=B9=A1=E2=80=9D=E7=9A=84=E7=
=A7=B0=E8=AA=89=E3=80=82 =E5=9C=A8=E5=A5=88=E8=89=AF=E9=95=BF=E5=A4=A7=E7=
=9A=84=E8=90=A5=E5=85=BB=E5=B8=88=E5=AF=8C=E5=86=88=E7=BE=8E=E6=99=BA=E5=AD=
=90=E7=A0=94=E7=A9=B6=E9=95=BF=E5=AF=BF=E7=9A=84=E5=81=A5=E5=BA=B7=E9=A5=AE=
=E9=A3=9F=EF=BC=8C=E5=A5=B9=E7=BB=8F=E5=B8=B8=E5=9C=A8CNBC=E4=B8=8A=E6=92=
=B0=E6=96=87=E5=88=86=E4=BA=AB=E6=97=A5=E6=9C=AC=E9=A5=AE=E9=A3=9F=E4=B9=A0=
=E6=83=AF=E3=80=82</p><p style=3D"color:rgb(0,0,0);font-family:&quot;Times =
New Roman&quot;;font-size:medium"><span class=3D"gmail-auto-style3" style=
=3D"font-family:&quot;Microsoft YaHei&quot;">=E5=A5=B9=E8=A1=A8=E7=A4=BA=EF=
=BC=8C=E4=B8=BA=E4=BA=86=E6=B4=BB=E5=BE=97=E6=9B=B4=E9=95=BF=E5=AF=BF=E3=80=
=81=E6=9B=B4=E5=BF=AB=E4=B9=90=EF=BC=8C=E5=A5=B9=E5=AE=B6=E7=9A=84=E5=8E=A8=
=E6=88=BF=E5=BF=85=E5=A4=878=E7=A7=8D=E9=A3=9F=E7=89=A9=EF=BC=8C=E8=80=8C=
=E4=B8=94=E6=AF=8F=E5=A4=A9=E9=83=BD=E5=90=83=E3=80=82=E9=82=A3=E4=B9=88=E8=
=BF=99 8 =E7=A7=8D=E9=A3=9F=E7=89=A9=E6=98=AF=E4=BB=80=E4=B9=88=E5=91=A2=EF=
=BC=9F</span><br class=3D"gmail-auto-style2" style=3D"font-family:&quot;Mic=
rosoft YaHei&quot;"></p><p style=3D"color:rgb(0,0,0);font-family:&quot;Time=
s New Roman&quot;;font-size:medium"><span class=3D"gmail-auto-style2" style=
=3D"font-family:&quot;Microsoft YaHei&quot;">1. =E6=8A=B9=E8=8C=B6</span><b=
r class=3D"gmail-auto-style2" style=3D"font-family:&quot;Microsoft YaHei&qu=
ot;"><span class=3D"gmail-auto-style2" style=3D"font-family:&quot;Microsoft=
 YaHei&quot;">2. =E5=8F=91=E9=85=B5=E9=A3=9F=E5=93=81</span><br class=3D"gm=
ail-auto-style2" style=3D"font-family:&quot;Microsoft YaHei&quot;"><span cl=
ass=3D"gmail-auto-style2" style=3D"font-family:&quot;Microsoft YaHei&quot;"=
>3. =E6=B5=B7=E8=97=BB</span><br class=3D"gmail-auto-style2" style=3D"font-=
family:&quot;Microsoft YaHei&quot;"><span class=3D"gmail-auto-style2" style=
=3D"font-family:&quot;Microsoft YaHei&quot;">4. =E8=B1=86=E7=B1=BB</span><b=
r class=3D"gmail-auto-style2" style=3D"font-family:&quot;Microsoft YaHei&qu=
ot;"><span class=3D"gmail-auto-style2" style=3D"font-family:&quot;Microsoft=
 YaHei&quot;">5. =E8=B1=86=E8=85=90...</span><br class=3D"gmail-auto-style2=
" style=3D"font-family:&quot;Microsoft YaHei&quot;"><br class=3D"gmail-auto=
-style2" style=3D"font-family:&quot;Microsoft YaHei&quot;"><span class=3D"g=
mail-auto-style2" style=3D"font-family:&quot;Microsoft YaHei&quot;">=E8=BF=
=98=E6=9C=89=E6=9B=B4=E5=A4=9A</span><br class=3D"gmail-auto-style2" style=
=3D"font-family:&quot;Microsoft YaHei&quot;"><br class=3D"gmail-auto-style2=
" style=3D"font-family:&quot;Microsoft YaHei&quot;"><span class=3D"gmail-au=
to-style2" style=3D"font-family:&quot;Microsoft YaHei&quot;">=E4=BB=A5=E4=
=B8=8B=E6=98=AF=E6=96=87=E7=AB=A0=E7=9A=84=E4=B8=BB=E8=A6=81=E5=86=85=E5=AE=
=B9=EF=BC=9A</span><br class=3D"gmail-auto-style2" style=3D"font-family:&qu=
ot;Microsoft YaHei&quot;"></p><p class=3D"gmail-auto-style2" style=3D"font-=
family:&quot;Microsoft YaHei&quot;;font-size:medium;color:rgb(0,0,0)"><a hr=
ef=3D"https://sumo.ad/changshou-ren-chi-shenme7" target=3D"_blank">https://=
sumo.ad/changshou-ren-chi-shenme7</a></p><p style=3D"color:rgb(0,0,0);font-=
family:&quot;Times New Roman&quot;;font-size:medium">=C2=A0</p><p class=3D"=
gmail-auto-style2" style=3D"font-family:&quot;Microsoft YaHei&quot;;font-si=
ze:medium;color:rgb(0,0,0)">=E7=A5=9D=E4=BD=A0=E4=B8=80=E5=88=87=E9=83=BD=
=E5=A5=BD=EF=BC=81</p><p class=3D"gmail-auto-style9" style=3D"font-size:11.=
5pt;color:rgb(91,102,116)">---</p><p class=3D"gmail-auto-style14" style=3D"=
font-family:&quot;Microsoft YaHei&quot;;color:rgb(0,123,255);font-size:medi=
um">=E8=BF=BD=E5=AF=BB=E7=9C=9F=E7=9B=B8=EF=BC=8C=E6=98=AF=E5=AF=B9=E8=89=
=AF=E7=9F=A5=E6=9C=80=E5=A5=BD=E7=9A=84=E5=B0=8A=E9=87=8D</p></div>

--000000000000f075dc065408b3fa--

