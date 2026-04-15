Return-Path: <linux-erofs+bounces-3309-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEpLMjt432kATgAAu9opvQ
	(envelope-from <linux-erofs+bounces-3309-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2026 13:36:27 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D09403E34
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Apr 2026 13:36:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwf8Q0MNkz2yvL;
	Wed, 15 Apr 2026 21:30:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1144" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776252629;
	cv=pass; b=bhwfZM6rzdMYUo3NSuu6niVw3pWlbivhKcEDzTGMCTCCN+KEfc9ucCbcGIlX4yVMuIBKhroLQbM7MySGXp0VHydL/1NlavX4EAyUe4BPmBlUuVXKgZQzrjq/D6AGdViKRlLW/pu/jcKRofF2qYFa+7oFpjPzoJ0ib3hnV1w+ynBlaFGIq7MgikIcsfWdh3J4KbLTeezUZwbpCggQXuXz1niULJ5sE274TkdLASzXlIOWpMarfsDktl50cmC9dvm3LBUh7p2NzmrvBhy7cRNF+A7klXZVNRzmWD058QFOZf3Rmchxwb47poHNG42jH5kqTYZZ3pVGCBNa+zUJtMJBSA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776252629; c=relaxed/relaxed;
	bh=6lnO6Aq6IdisaEjPRsgTuvEzrtRaBHFjvYMYt55wqeU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MOQzIygBKotf3wR6cnUjCrLM93nM1VYIChzfJO5h4zcQjjen1R7Yg5dCelRWBb3zUrjq5LPSGUTqI1QGOBOqdCIXoCjACv3M3FlmzQs3D0a0clbz/hgxIcbsni0KeR113563yn/R8U6p0eeJn12cC6OcDYolmegEYGQle+0HcKyHxkmO3TU2nHy0twdrl+OH8hW6zJJVagtm7oDi+uz4lLfkt6UrnxKOxSvqXjmOzE8rNPgriiMO/2oDF8Igac/3eneoijy8HV4s4FQ2f8i2tCKqrP8NXZ2ncTKbf97mgTdQA0QHfKn6CvfsW65HqxfChHAhSErv0OXUrYKbrSFIvQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Sc+pSFx0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1144; helo=mail-yw1-x1144.google.com; envelope-from=jomanayambo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Sc+pSFx0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1144; helo=mail-yw1-x1144.google.com; envelope-from=jomanayambo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwf8N1Mh2z2yrM
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2026 21:30:27 +1000 (AEST)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-7982c3b7dfcso65408717b3.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 15 Apr 2026 04:30:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776252624; cv=none;
        d=google.com; s=arc-20240605;
        b=g+o+C6NKkUy0fBzv9sZ58dNKD6duN2Siuyp4nRN5X7SoXRQfT+cji9I8ZWEiJo0X+c
         gVgnlzc5v9DiJlIL0p+Dh3uIzV9UUvo+di6lmpFovUIJtG/zKU8CaMudLITxaF4iLhp4
         9kcm+n64T+xYyoP67vYqj+OHelpWmENET6/IY4TdU/hwBU7fCCgiVcoVF+/4fglNYsjg
         Czau6FcwnjYyNT0lYY9CgnReKhC5pATVDtthWzYMHFVPUumE3zWaGQ0/jCXvJLclv5Q1
         PMJMfnrVHiEyxKsJO1C9hho16pWtC6/Yx/rTc9bpL9zW7Rnf6Kua7I6oYxXTItV9403W
         e5xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=6lnO6Aq6IdisaEjPRsgTuvEzrtRaBHFjvYMYt55wqeU=;
        fh=Tm3MMH6naFuTcyhcit9+SNFc4YTqZvbl4mqmPTXGnT4=;
        b=Jz1QfIp1Ak3IqgSLOpHgedw7d8t2wF8tR9BkZx1cTY6AewphCGXPgV3fw+yOjoHkCw
         6fMgy1dqIIbiIvhwVWgiYsx8v55WyC1vsSUS3+S9r8OeMDm3rWDzFgHotPbdDUh36N5j
         /wyffZpHuoT4RUkuFbOkK7DPBcFciWdYJBUHWYeBafFSBazVZIePJs/Eufo5oztq5tP+
         8hqTJsbDYcTuWVFYwvtWzD99LdSzVg0XzIjPOUW+uAYH5IOByLaSGftvcIagqlPZAjfT
         seENFux4deGNEYWpmOUJAQf6wm0ntBdohkz4ROSMW1eHQhAZQiosJa41kcOywFGEoYXu
         MWlA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776252624; x=1776857424; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6lnO6Aq6IdisaEjPRsgTuvEzrtRaBHFjvYMYt55wqeU=;
        b=Sc+pSFx0AFy/PWZV3A24Ud42QDfmCbqSkCFuU3p0WT7J0sfxsn/znpReT5iqyRwfpc
         WH2asWbYt+uwa1Qh2OhY3sManzGt7Broo1Gsv9Dj9tVfzWZyW/BB3e8O/lboxqtKZrYS
         EK03ZgJS5BK4e6sdV9bYs4BAptmek2u0qHYYLf4PLvmNUi6nKQUqoHEFzAIVpAOOqZay
         cdl6Fb10s6tvW89gvHDpu/C/g5BjlJ4Ag5QWuAKkIEiuhimUTZpXQVtfZCIUlM8yd6Q+
         WfeXJhOUTYoFtm2VcaWAhAfWwwN7VGWQ341K53tPbqeMMh/pXw2XWkjpG+4GYgDbkKNr
         LKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776252624; x=1776857424;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lnO6Aq6IdisaEjPRsgTuvEzrtRaBHFjvYMYt55wqeU=;
        b=jWhWfJ3I0Rv+biwGNVPkY8G1OJfAtdtBURcIn2g6/4IHzRhIXY65BDr4US44eZjwQ5
         r0FTPW6VGYdo0APYpWog3byVpLzqUKn3dcwtACJZQki6shLFVLynifuCxfr0P4g9MSsp
         y+eE6HqfaVBPqIeG5Ur+NmKueA3QBHCfPySh8pP2RNIS4BO/YAdELQm1TV6XzND/EmUM
         H69cgIbFz4rstHRo9918L6IPuRhXCV6cItyIdBJ4ckdlkT5bsPFSK3BgLOczRogsxTby
         l4hay7JOlr428CTINXE5AxGci9A6Q72iEWrJIfes3ZhklMldSBMc464EfxcS5MqwWA2U
         yyiw==
X-Gm-Message-State: AOJu0YxlJSLGiJvDi346T8zNY3rYyF1jAMND6QF1vXDs9UpH14GmLE2y
	jmoloMjBPxqpaNE6biqT/lIuvbdV+PGIRFqqPZjiER7j3g8hGRpIQaOlQbLF+b7+Og1gWgUW5FD
	tJIYe2YuC8sSUkRGQTIMZtkVu8a10R3oFwKfrsNWX/3Tu
X-Gm-Gg: AeBDieu/lFE4HhVBRNPi7Anl1Y681Vp/xhfPbRHt0Pt0j4X8zpPq3kJuxlhu+AWeLRJ
	gLZYskqJ//QloEARZ0H83b1oqZg2H/oYQdmkjiFZRAN2c2ZJwUJDFM7OoudSBFN1nIa9iqxn4Ax
	RtYdGN2/aGF01hrkCvBIiu9BJxy6mq5GkNMLNecqHkkcclnWqUSEMjSbuG3hNAe+Qe5a5ZNScpN
	j3g5bcMo6EalUzn5jET5KaXbBHrP6AiKKh6LheyLZmICzNxTxoHGnz1+88Z8si4eZIrjy5vAiGC
	/6Pfgq78wx0LMyzt3s5fxjBH4gEbZ6cgDFATORFFsgVwPdd66LhjtHdpxo/Jet45nnuLbX6DHzS
	2zmwdYUvaRSkUAH18QGr35jbsgaYRmImiqGC3URfm8PTcDcGgx7Nt7hvU3Ra48jjSS+oLxBacLz
	q2EaRaxPOjtt6EmjTZCsZ72JFE6rXoPorZ5vP9QWsyX1zbXdF5z0+Lv8pA2fQFPLa1Mbl+jexsQ
	z3lteRFL9MY5+UiloApeo7NDgf9ZI7+LojizG+OsJ3Ns/WIpoRfrVfuWAgZhI+CR0OZeI4Im3Le
	bI+ji3LEdlwq/CBHtra/+pQn6udGqEWb
X-Received: by 2002:a05:690c:39c:b0:798:704e:9d7e with SMTP id
 00721157ae682-7af72243f4cmr208094147b3.52.1776252624554; Wed, 15 Apr 2026
 04:30:24 -0700 (PDT)
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
From: Jomana Yambo <jomanayambo@gmail.com>
Date: Wed, 15 Apr 2026 18:30:12 +0700
X-Gm-Features: AQROBzAqeUDA_cGhdK4SX85BsDKJzWtOkIEk5P1dKvJrOB9bysBoTAYyED78V08
Message-ID: <CAF-Yj0crUNcJd7uzAp3G_drViSEXbJxkbjnuq+BXMeTBB8Fdkg@mail.gmail.com>
Subject: =?UTF-8?B?6K2m5oOV77yB5bGP5bmV5pe26Ze05LiO5YS/56ul6L+R6KeG6aOO6Zmp5aKe5Yqg55u4?=
	=?UTF-8?B?5YWz?=
To: linux-erofs@lists.ozlabs.org, 2bxunibidev@users.noreply.github.com, 
	327389438@qq.com, zibochen@westlake.edu.cn, fariy_vip@2925.com
Content-Type: multipart/alternative; boundary="000000000000b7d054064f7e0a63"
X-Spam-Status: No, score=2.3 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_DBL_SPAM
	autolearn=disabled version=4.0.1
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [10.42 / 15.00];
	FUZZY_DENIED(10.51)[1:d0a56120b3:0.78:txt];
	MAILLIST(-0.19)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3309-lists,linux-erofs=lfdr.de];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lists.ozlabs.org,users.noreply.github.com,qq.com,westlake.edu.cn,2925.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jomanayambo@gmail.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-erofs];
	ARC_ALLOW(0.00)[lists.ozlabs.org:s=201707:i=2];
	NEURAL_SPAM(0.00)[0.987];
	R_SPF_ALLOW(0.00)[+ip4:112.213.38.117:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sumo.ad:url,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D4D09403E34
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

--000000000000b7d054064f7e0a63
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

KuS9oOWlvSEqDQoNCuS9oOefpemBk+WQl++8n+S4gOmhueacgOaWsOeglOeptuihqOaYju+8jOWN
s+S9v+avj+WkqeWPquacieS4gOWwj+aXtueahOaXtumXtOebr+edgOWxj+W5le+8jOi/keinhuea
hOmjjumZqeS5n+S8muaYvuiRl+WinuWKoO+8jOeJueWIq+aYr+WvueS6juWEv+erpeiAjOiogOOA
gueglOeptuS6uuWRmOWPkeeOsO+8jOavj+WkmuiKseS4gOS4quWwj+aXtuingueci+eUteWtkOWx
j+W5le+8jOi/keinhueahOWPkeeUn+mjjumZqeS+v+S8mumaj+S5i+WinuWKoDIxJeOAgg0KDQrp
mL/liqDnk6blsJTlu7rorq7vvIzml6DorrrmmK/lranlrZDov5jmmK/miJDlubTkurrvvIzmr4/l
pKnov5vooYzlpKfnuqbkuKTkuKrlsI/ml7bnmoTmiLflpJbmtLvliqjmnInliqnkuo7pooTpmLLm
iJbmjqjov5/ov5Hop4bnmoTlj5HnlJ/jgIINCg0K5Li657yT6Kej6ZW/5pe26Ze06L+R6Led56a7
5bel5L2c5bim5p2l55qE55y8552b5Y6L5Yqb77yM5aW55bu66K6u6YG15b6q4oCcMjAtMjAtMjDm
s5XliJnigJ3vvIzljbPmr48yMOWIhumSn+S8keaBrzIw56eS77yM55yL55yLMjDoi7HlsLrov5zn
moTkuJzopb/jgIINCg0K6L+Z5p2h5L+h5oGv5p6B5YW26YeN6KaB77yM6K+35Yqh5b+F54K55Ye7
5p+l55yL77yBDQoNCmh0dHBzOi8vc3Vtby5hZC9waW5nLW11LXNoaS1qaWFuLXl1LWVyaHANCg0K
56Wd5L2g5ZKM5L2g55qE5a625Lq65aW96L+Q77yBDQoNCi0tLQ0KDQrkuJbnlYzlm6DlloToia/o
gIzmuKnmmpbvvIzlm6DnnJ/nm7jogIzmuIXphpINCg==
--000000000000b7d054064f7e0a63
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PHNwYW4gY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9u
dC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7O2ZvbnQtc2l6ZTptZWRpdW07Y29s
b3I6cmdiKDAsMCwwKSI+PHN0cm9uZz7kvaDlpb0hPC9zdHJvbmc+PC9zcGFuPjxiciBjbGFzcz0i
Z21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFI
ZWkmcXVvdDs7Zm9udC1zaXplOm1lZGl1bTtjb2xvcjpyZ2IoMCwwLDApIj48YnIgY2xhc3M9Imdt
YWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVp
JnF1b3Q7O2ZvbnQtc2l6ZTptZWRpdW07Y29sb3I6cmdiKDAsMCwwKSI+PHNwYW4gY2xhc3M9Imdt
YWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVp
JnF1b3Q7O2ZvbnQtc2l6ZTptZWRpdW07Y29sb3I6cmdiKDAsMCwwKSI+5L2g55+l6YGT5ZCX77yf
5LiA6aG55pyA5paw56CU56m26KGo5piO77yM5Y2z5L2/5q+P5aSp5Y+q5pyJ5LiA5bCP5pe255qE
5pe26Ze055uv552A5bGP5bmV77yM6L+R6KeG55qE6aOO6Zmp5Lmf5Lya5pi+6JGX5aKe5Yqg77yM
54m55Yir5piv5a+55LqO5YS/56ul6ICM6KiA44CC56CU56m25Lq65ZGY5Y+R546w77yM5q+P5aSa
6Iqx5LiA5Liq5bCP5pe26KeC55yL55S15a2Q5bGP5bmV77yM6L+R6KeG55qE5Y+R55Sf6aOO6Zmp
5L6/5Lya6ZqP5LmL5aKe5YqgMjEl44CCPC9zcGFuPjxiciBjbGFzcz0iZ21haWwtYXV0by1zdHls
ZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDs7Zm9udC1z
aXplOm1lZGl1bTtjb2xvcjpyZ2IoMCwwLDApIj48YnIgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUx
IiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7O2ZvbnQtc2l6
ZTptZWRpdW07Y29sb3I6cmdiKDAsMCwwKSI+PHNwYW4gY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUx
IiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7O2ZvbnQtc2l6
ZTptZWRpdW07Y29sb3I6cmdiKDAsMCwwKSI+6Zi/5Yqg55Om5bCU5bu66K6u77yM5peg6K665piv
5a2p5a2Q6L+Y5piv5oiQ5bm05Lq677yM5q+P5aSp6L+b6KGM5aSn57qm5Lik5Liq5bCP5pe255qE
5oi35aSW5rS75Yqo5pyJ5Yqp5LqO6aKE6Ziy5oiW5o6o6L+f6L+R6KeG55qE5Y+R55Sf44CCPC9z
cGFuPjxiciBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVv
dDtNaWNyb3NvZnQgWWFIZWkmcXVvdDs7Zm9udC1zaXplOm1lZGl1bTtjb2xvcjpyZ2IoMCwwLDAp
Ij48YnIgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7
TWljcm9zb2Z0IFlhSGVpJnF1b3Q7O2ZvbnQtc2l6ZTptZWRpdW07Y29sb3I6cmdiKDAsMCwwKSI+
PHNwYW4gY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7
TWljcm9zb2Z0IFlhSGVpJnF1b3Q7O2ZvbnQtc2l6ZTptZWRpdW07Y29sb3I6cmdiKDAsMCwwKSI+
5Li657yT6Kej6ZW/5pe26Ze06L+R6Led56a75bel5L2c5bim5p2l55qE55y8552b5Y6L5Yqb77yM
5aW55bu66K6u6YG15b6q4oCcMjAtMjAtMjDms5XliJnigJ3vvIzljbPmr48yMOWIhumSn+S8keaB
rzIw56eS77yM55yL55yLMjDoi7HlsLrov5znmoTkuJzopb/jgII8L3NwYW4+PGJyIGNsYXNzPSJn
bWFpbC1hdXRvLXN0eWxlMSIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhl
aSZxdW90Oztmb250LXNpemU6bWVkaXVtO2NvbG9yOnJnYigwLDAsMCkiPjxiciBjbGFzcz0iZ21h
aWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkm
cXVvdDs7Zm9udC1zaXplOm1lZGl1bTtjb2xvcjpyZ2IoMCwwLDApIj48c3BhbiBjbGFzcz0iZ21h
aWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkm
cXVvdDs7Zm9udC1zaXplOm1lZGl1bTtjb2xvcjpyZ2IoMCwwLDApIj7ov5nmnaHkv6Hmga/mnoHl
hbbph43opoHvvIzor7fliqHlv4Xngrnlh7vmn6XnnIvvvIE8L3NwYW4+PGJyIGNsYXNzPSJnbWFp
bC1hdXRvLXN0eWxlMSIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZx
dW90Oztmb250LXNpemU6bWVkaXVtO2NvbG9yOnJnYigwLDAsMCkiPjxiciBjbGFzcz0iZ21haWwt
YXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVv
dDs7Zm9udC1zaXplOm1lZGl1bTtjb2xvcjpyZ2IoMCwwLDApIj48c3BhbiBjbGFzcz0iZ21haWwt
YXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVv
dDs7Zm9udC1zaXplOm1lZGl1bTtjb2xvcjpyZ2IoMCwwLDApIj48YSBocmVmPSJodHRwczovL3N1
bW8uYWQvcGluZy1tdS1zaGktamlhbi15dS1lcmhwIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9z
dW1vLmFkL3BpbmctbXUtc2hpLWppYW4teXUtZXJocDwvYT48L3NwYW4+PGJyIGNsYXNzPSJnbWFp
bC1hdXRvLXN0eWxlMSIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZx
dW90Oztmb250LXNpemU6bWVkaXVtO2NvbG9yOnJnYigwLDAsMCkiPjxiciBjbGFzcz0iZ21haWwt
YXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVv
dDs7Zm9udC1zaXplOm1lZGl1bTtjb2xvcjpyZ2IoMCwwLDApIj48c3BhbiBjbGFzcz0iZ21haWwt
YXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVv
dDs7Zm9udC1zaXplOm1lZGl1bTtjb2xvcjpyZ2IoMCwwLDApIj7npZ3kvaDlkozkvaDnmoTlrrbk
urrlpb3ov5DvvIE8L3NwYW4+PGRpdj48c3BhbiBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0
eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDs7Zm9udC1zaXplOm1l
ZGl1bTtjb2xvcjpyZ2IoMCwwLDApIj48cCBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTkiIHN0eWxl
PSJmb250LWZhbWlseTpBcmlhbCxIZWx2ZXRpY2Esc2Fucy1zZXJpZjtmb250LXNpemU6MTEuNXB0
O2NvbG9yOnJnYig5MSwxMDIsMTE2KSI+LS0tPC9wPjxwIGNsYXNzPSJnbWFpbC1hdXRvLXN0eWxl
MTQiIHN0eWxlPSJjb2xvcjpyZ2IoMCwxMjMsMjU1KSI+5LiW55WM5Zug5ZaE6Imv6ICM5rip5pqW
77yM5Zug55yf55u46ICM5riF6YaSPC9wPjwvc3Bhbj48L2Rpdj48L2Rpdj4NCg==
--000000000000b7d054064f7e0a63--

