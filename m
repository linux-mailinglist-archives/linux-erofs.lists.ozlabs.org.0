Return-Path: <linux-erofs+bounces-487-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDA1AE6437
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Jun 2025 14:06:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bRNvZ06NFz30MY;
	Tue, 24 Jun 2025 22:06:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750766761;
	cv=none; b=izBVLDmUFSCZn0sm8mgL4co+6eSWehOExHk6vlj+2izoyF4pDLZiQS4tgY/4uo5dF5OJe+XcZmAVrtw5xbCIm6PDunzTnzg9TbiK9zieAdEBGS4iYNNZZFtgonAceXQ1J7LMFfCluCO3J1uL+AACHI+eZ4VGdeC5f80q2Qqw6Vqrg7dYS+MmTrWg/fGlfbkJhTrx4BlmHCVMgVvWlMDrUWghp4J02mDbJnJHfBlYFCaxx0FgaBZDRKxCxfJ5RIy4RWCB3b8PpXZ7Zn9jyA4Fuhv/Or3liIB0wOkIeDJGTtkxwb9YhUueMfAIp2EePTo5kqvdmLObS1ufC4Pv8oQGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750766761; c=relaxed/relaxed;
	bh=Sh7c6kew5778xkT2w/ivEsewc4Q0gkbMeZ6m7AAGY/k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JHStfKF/sV4JuvBB+haaW1u7Ps1477ueviz9K7ZU3HYsOgqYBOa7vV2xt5iZYHB3twigEbG+t8giXCt76zTnCyNSN+8iXGNA2rEGVRe39/aUVCYofgt6X/9efNqPzKrBwnjm/7XEi+AKPqgSF4xElbJrQnoDjwZT+fZKnjJj1kPwmC97qTkK2a7RVPcBKXL1gfwHzz7l+4kIyVpDk21spBdtlickBgnvbr0NUwcv1RwbAhHdlzyMAsW4UbgBorwgocAiipdjCkKg3vC42ub2DgqeFjvxVv+YPg9sOPeBCzfHj5kQx6hVkxPXR3KUgaYAvaUZlDqujGyKtXT4bzpCog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NfjCmc21; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=khanhlongfaq@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NfjCmc21;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=khanhlongfaq@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bRNvX0RQtz2xHZ
	for <linux-erofs@lists.ozlabs.org>; Tue, 24 Jun 2025 22:05:58 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so4215276b3a.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 24 Jun 2025 05:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750766756; x=1751371556; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Sh7c6kew5778xkT2w/ivEsewc4Q0gkbMeZ6m7AAGY/k=;
        b=NfjCmc21O2Zvlf36EGVBYXFHtWhAoly3lzVqa7cqU7xMSwiAVxfAvh7chuUKp1XvgM
         4t3aRe4qktdXgrXIfk9ciWAKRXBUvrFr5BY3iXuElSDd4fD1IuWWdZ8VwTOylM7PSLPt
         Em9GigfYC5yMzQHMUptNmXpo1tB5I7e8AtY7i6Yiehng63u1sFe67L6PVhF4M5oqdF1+
         OVwUTskBkM1kn3UvN4R8G7gKYMwv/mcf8OlclteiRaxN9do+c7TRYK2MyhwjdhSGia/V
         pUuErCeeqiwXnXTUIpRCByq1vaR4awXK4EuUjKqvyYOWsBil165V5FdZzixosRvkTfM4
         GZ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750766756; x=1751371556;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sh7c6kew5778xkT2w/ivEsewc4Q0gkbMeZ6m7AAGY/k=;
        b=SLUDu+/C+FPR4DRpWGE9p/bB+dFntwi+czpX/vsN0RzpXodHoktyTA+GpphrT05Ok3
         KBy7K2t177mPZp1cpsjJGn6ccqvcf5rRJJVvg8syMnsUklR9DohNFdxK6dkVM6w8fTCU
         eJ5TupGU5FfgrXJR4MmUt9ns62OzWKe+xUrRUl6zCJuKU0vfW/R7KNl9W1LSsHU5j86o
         WO5o9yk0nXRzMd311MUIuEAaFbeBZYa16QreP/mOvb9onE/dVdFsFT+1q56IuIdU9RkG
         VXlHnK5+NfXJ+enBQSUjBo0G1Zyq2nRmuKq4GYQ5YlvbonBZjnmMejlh9zcCNNkQa1nA
         5duA==
X-Gm-Message-State: AOJu0Yz+HgQFoQ/0Mzcj3K5/jBuLAYsIPWnWjbZ+YPf+obbiN29Ox/Fu
	10+vsY/8eSotWhslDsnR9oBsOC8TDIWQqsTDj1OWTqlSpswxpe+vvLI6t82I/7oBJlYUSSkIG46
	+1FNhHs3fjAFH+VvmgVU2pOKEC4i91O33Kkkw
X-Gm-Gg: ASbGncuY1ExlX9BKczBPwxxU3g/aB2ehiJrW4uOXeQ31GNqwMaZdCnvUzOAtU3SwCjj
	Y1u6gGZRGEgVssvIKuuAoLC/FC/AGaf67ZyGO6JF0I3paH5iN96mDUsdBBBdBQGEvnpTBoOy5oa
	MuHyRJ9mZ19bcnUXEEiGXw5+LECLxmLj3Jj95XuIJqF7Nu
X-Google-Smtp-Source: AGHT+IETAb5yfj0q/tba6+sGsTpLnZExMkwPJoTfAX7SjuuLxRea45rLGklvofc+G3SJUsSortYjI7fiqLKYvkCpabU=
X-Received: by 2002:a05:6a00:14d1:b0:74a:cd4d:c0a6 with SMTP id
 d2e1a72fcca58-74acd4dc5edmr1406097b3a.5.1750766755736; Tue, 24 Jun 2025
 05:05:55 -0700 (PDT)
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
From: Bridget Khanh <khanhlongfaq@gmail.com>
Date: Tue, 24 Jun 2025 19:05:44 +0700
X-Gm-Features: AX0GCFtfGtdlBLseSLZebtzZPg4YLv4xgG2eOIYg10ebsNVMydw6mTuLtqCn3dQ
Message-ID: <CAOFBJ_EGV8JDW+_HwYTvpsMYoj70AjJ44bc-9Scra4iqE0cWPA@mail.gmail.com>
Subject: =?UTF-8?B?Oeenjei1mumSseaKgOiDvSDkuIDlubTlhoXlj6/lrabkvJrlubbojrforqTor4E=?=
To: linux-erofs@lists.ozlabs.org, byndxwb@163.com, xiaol@eol.cn, 
	sjyz.sl@cqust.edu.cn, livey@psb.vib-ugent.be
Content-Type: multipart/alternative; boundary="0000000000008f74810638502603"
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

--0000000000008f74810638502603
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

KuS9oOWlvSEqDQoNCuaXoOiuuuaYr+WvueebruWJjeeahOW3peS9nOWSjOaKpemFrOaEn+WIsOWO
jOWApuW4jOacm+aUueihjO+8jOi/mOaYr+W+heS4muS4reWvu+aJvui/m+WFpeafkOihjOS4muea
hOaxguiBjOKAnOaVsumXqOegluKAne+8jOWcqOaWsOmihuWfn+iOt+W+l+ebuOWFs+e7k+S4muiu
pOivgemDveS8muS9v+S9oOmdouWvueacquadpeaXtuS/oeW/g+a7oea7oeOAgg0KDQrogIzlrp7p
mYXkuIrvvIzmnInkuIDkupvmioDog73lrabkuaDotbfmnaXlubbkuI3pnIDopoHpgqPkuYjplb/n
moTml7bpl7TvvIzog73lpJ/lvojlv6vlhaXmiYvvvIzogIzkuJTolqrmsLTlubbkuI3kvY7vvIzl
sLHkuJrliY3mma/kuZ/lvojlub/pmJTjgIINCg0K6L+Z56+H5paH56ug5oyH5Ye65LqGOeenjeWc
qOS4gOW5tOWGheWPr+S7peWtpuS8muW5tuiOt+W+l+S4k+S4muiupOivgeeahOi1mumSseaKgOiD
veOAgg0KDQropoHpmIXor7vlrozmlbTmlofnq6DvvIzor7fngrnlh7vkuIvpnaLnmoTpk77mjqXv
vJoNCg0KaHR0cHM6Ly90aW55dXJsLmNvbS85LXpob25nLXpodWFucWlhbi1qaW5lbmcNCg0K56Wd
5L2g5LiA5YiH6YO95aW977yBDQoNCi0tLQ0KDQrkuJbnlYzlm6DlloToia/ogIzmuKnmmpbvvIzl
m6DnnJ/nm7jogIzmuIXphpINCg==
--0000000000008f74810638502603
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PHAgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9udC1m
YW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7O2NvbG9yOnJnYigwLDAsMCk7Zm9udC1z
aXplOm1lZGl1bSI+PHN0cm9uZz7kvaDlpb0hPC9zdHJvbmc+PC9wPjxwIGNsYXNzPSJnbWFpbC1h
dXRvLXN0eWxlMSIgc3R5bGU9ImZvbnQtZmFtaWx5OiZxdW90O01pY3Jvc29mdCBZYUhlaSZxdW90
Oztjb2xvcjpyZ2IoMCwwLDApO2ZvbnQtc2l6ZTptZWRpdW0iPuaXoOiuuuaYr+WvueebruWJjeea
hOW3peS9nOWSjOaKpemFrOaEn+WIsOWOjOWApuW4jOacm+aUueihjO+8jOi/mOaYr+W+heS4muS4
reWvu+aJvui/m+WFpeafkOihjOS4mueahOaxguiBjOKAnOaVsumXqOegluKAne+8jOWcqOaWsOmi
huWfn+iOt+W+l+ebuOWFs+e7k+S4muiupOivgemDveS8muS9v+S9oOmdouWvueacquadpeaXtuS/
oeW/g+a7oea7oeOAgjwvcD48cCBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250
LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDs7Y29sb3I6cmdiKDAsMCwwKTtmb250
LXNpemU6bWVkaXVtIj7ogIzlrp7pmYXkuIrvvIzmnInkuIDkupvmioDog73lrabkuaDotbfmnaXl
ubbkuI3pnIDopoHpgqPkuYjplb/nmoTml7bpl7TvvIzog73lpJ/lvojlv6vlhaXmiYvvvIzogIzk
uJTolqrmsLTlubbkuI3kvY7vvIzlsLHkuJrliY3mma/kuZ/lvojlub/pmJTjgII8L3A+PHAgY2xh
c3M9ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0
IFlhSGVpJnF1b3Q7O2NvbG9yOnJnYigwLDAsMCk7Zm9udC1zaXplOm1lZGl1bSI+6L+Z56+H5paH
56ug5oyH5Ye65LqGOeenjeWcqOS4gOW5tOWGheWPr+S7peWtpuS8muW5tuiOt+W+l+S4k+S4muiu
pOivgeeahOi1mumSseaKgOiDveOAgjwvcD48cCBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0
eWxlPSJmb250LWZhbWlseTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDs7Y29sb3I6cmdiKDAs
MCwwKTtmb250LXNpemU6bWVkaXVtIj7opoHpmIXor7vlrozmlbTmlofnq6DvvIzor7fngrnlh7vk
uIvpnaLnmoTpk77mjqXvvJo8L3A+PHAgY2xhc3M9ImdtYWlsLWF1dG8tc3R5bGUxIiBzdHlsZT0i
Zm9udC1mYW1pbHk6JnF1b3Q7TWljcm9zb2Z0IFlhSGVpJnF1b3Q7O2NvbG9yOnJnYigwLDAsMCk7
Zm9udC1zaXplOm1lZGl1bSI+PGEgaHJlZj0iaHR0cHM6Ly90aW55dXJsLmNvbS85LXpob25nLXpo
dWFucWlhbi1qaW5lbmciPmh0dHBzOi8vdGlueXVybC5jb20vOS16aG9uZy16aHVhbnFpYW4tamlu
ZW5nPC9hPjwvcD48cCBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTEiIHN0eWxlPSJmb250LWZhbWls
eTomcXVvdDtNaWNyb3NvZnQgWWFIZWkmcXVvdDs7Y29sb3I6cmdiKDAsMCwwKTtmb250LXNpemU6
bWVkaXVtIj7npZ3kvaDkuIDliIfpg73lpb3vvIE8L3A+PHAgY2xhc3M9ImdtYWlsLWF1dG8tc3R5
bGU5IiBzdHlsZT0iZm9udC1zaXplOjExLjVwdDtjb2xvcjpyZ2IoOTEsMTAyLDExNikiPi0tLTwv
cD48cCBjbGFzcz0iZ21haWwtYXV0by1zdHlsZTE0IiBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7
TWljcm9zb2Z0IFlhSGVpJnF1b3Q7O2NvbG9yOnJnYigwLDEyMywyNTUpO2ZvbnQtc2l6ZTptZWRp
dW0iPuS4lueVjOWboOWWhOiJr+iAjOa4qeaalu+8jOWboOecn+ebuOiAjOa4hemGkjwvcD48L2Rp
dj4NCg==
--0000000000008f74810638502603--

