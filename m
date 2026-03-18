Return-Path: <linux-erofs+bounces-2819-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELdLLrAfuml8RwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2819-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 04:44:48 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D192B5908
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Mar 2026 04:44:46 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbF7w1MzPz2yZ5;
	Wed, 18 Mar 2026 14:44:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::f32"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773805484;
	cv=none; b=lLuN/U/vgJOKh4AqCcIj5dctXC6iPyVQDKNz7LWX4A1mb01Umzl9+ieaqa6MBWhs1oDmiX3J9GccKAQqRGXYpGDAX/n5KcEuwQG1mQJdoQUNQOZ1XYwuTcpviHfJiA/7D8NC3LlrVWeIcMhVDXXoHGc6uNeitXVdp+lsGG0cepe7y5riuDtGL28dd9IQqgNsjEMvMfAdc8g5GQ0hnqYZt9EsEOX5PbIjeCu4Bd7Bd2GA5+JWirIWQ4sDa6/VDtD5BvNaoa4GETMym3JFRnLv/PT1QCQhQcUSXEpMLRAr7LQDgB7lIxm7Zmb4mISWcUHRoOOKuK3/Ep7meoWAkKBSoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773805484; c=relaxed/relaxed;
	bh=m7Fbo9JpS8AwArBC/YtW6s6fV9Dc2cl2c3oZsIZ/8Hs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject; b=iWfIt0OP2CLMx4tTGZkZKQPge9uI2M1FoQmh/w9HB4sxiXwdWCMjUlZdZ3owGCLKzGJM8T3T+FCIaaPLvR4404tEqzMc1Im+wOUlvD5q1eMtyj1fgIjEhotkwjt/QwVf9owyPMR3sAEA5C8s+JPkDLfHqc4ZwgpN1bCFSY/rHzBrneIapmse1kNOsgh9aSU0DOY1CHlmfEzxHeRY+2pGdiWXvudEHXOEziu8wi/VxTa+EPYcELWyVwhEM1aWTyTizcsiEfg3wgHHsxlEmS2Xk93ChXaCQJ+WtAm3+aw25SXi+yesYzxisa0r5siX1MfkxfA9SXAtfG9GM3xw40KpuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SHeWo3nM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com; envelope-from=hxkddtid@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=SHeWo3nM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f32; helo=mail-qv1-xf32.google.com; envelope-from=hxkddtid@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbF7t2d4gz2xQB
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 14:44:41 +1100 (AEDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-89a07f66f4eso75765956d6.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 20:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773805477; x=1774410277; darn=lists.ozlabs.org;
        h=reply-to:subject:to:from:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7Fbo9JpS8AwArBC/YtW6s6fV9Dc2cl2c3oZsIZ/8Hs=;
        b=SHeWo3nMJdfrGJzhAwtKulTZn5nu/m+kYwliOc1PW0uH4XHThE3GINhAunxKgk1Ckf
         Ew70usacppuDSjUMcmLWd/xwcWz06g+OBRGCEEqG9wyZy6F9/U/PUFYN1wwa62NuyEpM
         tfY6DtaChT6/7H350ICQcgyZJagbYs2EsopcOcIgjJ5Xkuun0t5tW47uIV1c/Lt651Ar
         b5jMNebkqt0QRTmYIf1VWO75QTBpv3kOyx0yS8uC3emq5AqujJOT+H7rNRX52F6ti7v9
         zZMtTuJjLLRrw37Wmw4o3fR3mgSIuTnknPt9YGizXazK8/w0POjyNJa6wxdio5BzWdWN
         mh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773805477; x=1774410277;
        h=reply-to:subject:to:from:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m7Fbo9JpS8AwArBC/YtW6s6fV9Dc2cl2c3oZsIZ/8Hs=;
        b=jn4d5VYw35g3o6+aQeklFECErYTVBk4BhOtorxD3DJozbZAVXO6z0uI9rmcnZKRMBD
         cx+P9DIqolCs0DXUigIIuvinbvFzLLYaBImGoSukl2CGyXOef7RjqUccHN/OHYXzSnkt
         kX71KZnFVfvD2+8mtdlrLVPHYuAB+BC2wlskv9VkH/du/LWYs6qq6wmC/MG98ICdTsv7
         +0vKi3Yv6VNgIbXnRgf9CslMgADzrvFA9+6fud5MM5nvHbUbZHptHAn68wv+ZBOLbPeW
         imqGWJ2lHT1eFg6NhQP6XG1z0eDPNJu2NxPwMLAX6Zc5UszifkTNM/5xbza5pyB5kemp
         GRew==
X-Gm-Message-State: AOJu0YyDro+Id+FVUTKCbMkKy3h1Ip9sk+749Y3AfyckAMwm3ZCHEloG
	avJUzkh43DsmoV0VRvigxt4AsRlbvYdlKIPU56v+wKhr1kmtTGIzwJc0Pfc8zedn82dzUw==
X-Gm-Gg: ATEYQzyx+tYQ5P1oi3NXV8vLnEjNVok0CedhVnnjJbPHmPAL5dX5MiaR2e8UrjmSqFB
	/jwIHhpRml8LuKQ7XL0pk6A8NWipW//M7thWBddqdPdLc83h9NNbCg8phMgA41wEvUCLjv5P/NT
	oEBMEYba1SQC19QJ7vWkpbDXsXz+xEQDpaNmOq030UfmkWNo+QWCFauorZUpirn3vo/hJk+5pXa
	qErEbz9A3dJVMgB8poSYWK9c3pQdhY2s/cvZJmY7H3KIAxUNymJhk80asj0YdWrj1cVmdbiTSId
	Q9Fa9aSdK7PMJEn40Rdo4qJCBMK/DK4JSlz8D48QDgfSQiLUPl1E85JIAiUH7Tj0tQc+8SOrQz9
	+cl0PYT8VEn1J3p1VHa58LqsyaUS6xTlE5YU57Cwm6PoA3BZKxYsyTacslNWekegb8Z++/eozvQ
	qRSUsfi0IaVJ/PfOuYRcVXj4I5T82Fsfyx7StmaBS9bUNWjMQ=
X-Received: by 2002:a05:6214:4a93:b0:89c:4985:83d9 with SMTP id 6a1803df08f44-89c6b4a4078mr29998216d6.6.1773805477279;
        Tue, 17 Mar 2026 20:44:37 -0700 (PDT)
Received: from [172.20.10.3] ([89.222.100.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c6b90d1a8sm14763996d6.18.2026.03.17.20.44.36
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 20:44:36 -0700 (PDT)
Message-ID: <69ba1fa4.050a0220.c5968.fdc9@mx.google.com>
Date: Tue, 17 Mar 2026 20:44:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0595640904439264585=="
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
From: QATAR <hxkddtid@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: =?utf-8?q?Proposal_Documentation_Available_=C3=A2=E2=82=AC=E2=80=9C?=
 =?utf-8?q?_Project_Details_Included?=
Reply-To: qatar@eaviationgroups.com
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,HTML_MESSAGE,HTML_MIME_NO_HTML_TAG,MIME_HTML_ONLY,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [0.10 / 15.00];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	SUBJECT_HAS_CURRENCY(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MIME_HTML_ONLY(0.20)[];
	MAILLIST(-0.19)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-2819-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:~];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hxkddtid@gmail.com,linux-erofs@lists.ozlabs.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[qatar@eaviationgroups.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,mx.google.com:mid,eaviationgroups.com:replyto]
X-Rspamd-Queue-Id: E2D192B5908
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============0595640904439264585==
Content-Type: text/html; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6MTRw
eDsiPgo8cD5IZWxsbyAsPC9wPgoKPHA+UGxlYXNlIHJldmlldyB0aGUgYXR0YWNoZWQgZG9jdW1l
bnRhdGlvbiByZWdhcmRpbmcgb3VyIHByb3Bvc2FsLjwvcD4KCjxwPlRoZSBmaWxlIGluY2x1ZGVz
IHRoZSBwcm9wZXJ0eSBhZGRyZXNzLCB0ZWNobmljYWwgZHJhd2luZ3MsIHBsYW5zLCBhbmQgZnVs
bCBwcm9qZWN0IHNwZWNpZmljYXRpb25zLjwvcD4KCjxwPjxzdHJvbmc+UmVxdWVzdCBmb3IgUXVv
dGF0aW9uIOKAkyBWaWV3IHRoZSBQREY8L3N0cm9uZz48YnI+CjxhIGhyZWY9Imh0dHBzOi8vdXB3
dGEuYXBpZG9tYWluLmRpZ2l0YWwvTlRReE5qZGxNR1U2YkdsdWRYZ3RaWEp2Wm5OQWJHbHpkSE11
YjNwc1lXSnpMbTl5WncjWkdWa1pUVmpPR0U2YUhSMGNITTZMeTk2YjI5dGQyOXlhM053WVdObExt
TmpMMFpwYkdWemFHRnlaUzFrYjJOekxtaDBiV3ciPmh0dHBzOi8vdXB3dGEuYXBpZG9tYWluLmRp
Z2l0YWwvTlRReE5qZGxNR1U2YkdsdWRYZ3RaWEp2Wm5OQWJHbHpkSE11YjNwc1lXSnpMbTl5Wncj
WkdWa1pUVmpPR0U2YUhSMGNITTZMeTk2YjI5dGQyOXlhM053WVdObExtTmpMMFpwYkdWemFHRnla
UzFrYjJOekxtaDBiV3c8L2E+PC9wPgoKPHA+WW91ciBwcm9tcHQgcmVzcG9uc2Ugd291bGQgYmUg
Z3JlYXRseSBhcHByZWNpYXRlZCBhcyB3ZSBhcmUgd29ya2luZyB3aXRoaW4gYSBkZWZpbmVkIHBy
b2plY3QgdGltZWxpbmUuPC9wPgoKPHA+SSB3aWxsIGZvbGxvdyB1cCB3aXRoIGEgY2FsbCBvbmNl
IHlvdSBoYXZlIHJldmlld2VkIHRoZSBtYXRlcmlhbHMuPC9wPgoKPHA+VGhhbmsgeW91IGZvciB5
b3VyIHRpbWUgYW5kIGNvbnNpZGVyYXRpb24uPC9wPgoKPHA+UmVnYXJkcyw8YnI+ClN0YXRpb24g
TWFuYWdlcjwvcD4KCjxwIHN0eWxlPSJmb250LXNpemU6MTBweDtjb2xvcjojODg4OyI+UFI0RjJM
dXRpNE5DPC9wPgo8L2Rpdj4=

--===============0595640904439264585==--

