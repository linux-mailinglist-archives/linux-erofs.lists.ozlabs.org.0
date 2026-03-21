Return-Path: <linux-erofs+bounces-2902-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPniJa5FvmmvLQMAu9opvQ
	(envelope-from <linux-erofs+bounces-2902-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 08:15:58 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B622E3EF4
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 08:15:57 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fd9hC46mcz2yZN;
	Sat, 21 Mar 2026 18:15:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774077355;
	cv=none; b=Jicqg4RkzRjDzts1Kukm0LiVhV+nuBgmSnvLFo2icpVi+JgQCnZpJCyEVt3xCJ/48cA6Y8NM84OEv4thSXTmhyRgi3IJ1ckqaosMFWB1DC33d/hQCfw7gBTqg5NLmwdu4NycJMMrh6PthhOUDsp5Wr++R7max950knKxBk1IhT3vkuwvQVRJsZNiXxp3c9/wiy6TbDvuaBbRJbqYnO8dS0nxZ6teQy0K55sSCmi2/SbenWKIAXqE5NjalhNSw6XhF4U3Bc7mjVWBrR+5CFVJYVV+EAKZtj1VrWCtZsC9/VGNpAAsfP3vjVy7n/nyCSFRb8SLztiZWj+/mmeoTzw6Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774077355; c=relaxed/relaxed;
	bh=VMakM8eRVueloGSmlW1W+WwKfrHhfuGJQ6v1vKbrVC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsYYal0QO//u7pApw4yKgDN2lnYV3gwrQ8SWNugjq+fMe3pKlEcsiR0JGjgzy8yz7GAFCh6x7w1hVGWDmGGq4OfSZ3EU21kZCBlnkyWuxFm+rWs3z3UhLomwY0j3nph+Kf5sI6jPktvYbWtgk684eciuoL0IxoYd5y1w917MRqpYLJojBKTTqr4bpvmHL6CGNY5uk1CST7ADcj+uMI25h42LB56pxvPDd/+8q4t7tKmmvRg6Yslk46QqGfWIR9gVSzqKBfp5UV8aYdzC74Sj1xLKfh7FEMnCUE70iFVmB/C8+96YbCy3Il3m5Cqejq0Snh04uVv6dHPpfYZWCQL+Ag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=N6MpDX9j; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=N6MpDX9j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fd9hB3VlCz2yWy
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 18:15:54 +1100 (AEDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so10610145e9.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 00:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774077351; x=1774682151; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMakM8eRVueloGSmlW1W+WwKfrHhfuGJQ6v1vKbrVC8=;
        b=N6MpDX9jzLitfKKa9+X96awtY5Q3upx2ENXcPFJDv11kHxHfIcAC9jO6LGaODb0DPI
         xNwng6EP+Juepe3l6DcCP3/Dpb32HnBXJ1ZHYux7OTECoexd/aD68mztsvTGhDFGV4sy
         lseg8igfNnrXibv+suk6gHwQ9N4v0+dVvTqvef1O9tWi0F7YUEisxmA84P3OTdd8obKb
         HJriGi1X8DixRIicnX5/tEBwIBlzg1/J3T464VcIy0O+josFVZ797du0KkXpDzu6W3YM
         8QoVaZitE3/eee0d+5/AneOnLpyC16ZLRJTSvmWMdlVmmCZh0kmuaHr0EElrW94LZbTp
         5LcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774077351; x=1774682151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VMakM8eRVueloGSmlW1W+WwKfrHhfuGJQ6v1vKbrVC8=;
        b=omf3Gc0iUM6qdfZtA5bbFGwg1Ka5dn4GdnG6cbNKYvucZGAa9BB5q+LRNxJZvmlcBl
         O4obWOvinnCdTi5n96QAFpjK8J/i5QpFxByGt2I6s7LwFDkNIOEvnHxgJZAc9WDJ3Qy+
         qUhFVyklhvjVYL4k9VoVZVE7dx/zmtt+lKB4DFOU+8RZpEImwgSBKEi6ujxVupOY/Mhx
         AXJ73rwMODUezbrd++LL+A109RVNxLIBR5wP4dH60NqpFqSJe63C2fHJMRT/6FY1wFdU
         aIu5RgeIkM5dawlsySCuE3vT3J2jCvxfL7/iuMmk64YKbPCEAEXJq8hjHhd2rGcem8Br
         3o1g==
X-Gm-Message-State: AOJu0YyqFT5cqjHUnxGucM+P9xLIIv/a1IeRrCGLdhhCiJBqMk8AoMRF
	zgSyIunLidYFKsZR+IJqAFs2r3BKIFNrWThi+dSdhb9wqT/PyCFmp+k6
X-Gm-Gg: ATEYQzyC7h24S7NUxq5NRyVQt/fKXP3xsXRHT7Zbg9ls/2TMJxkcwQxyUEt5FY4leL9
	ZSudV0S4wXBgdJMmx7qcNCGJyNsVgeilYj1PVLjmOcKv3bWvktPp3HbMci9SGIM88zmlSiwIH0v
	RvNP7LeqTGukNVmtqjurPyaNULarjRIF2RlRv9nWAjp0bBVaSA3FHx9pztVkOV/0HVIk4MgGVuf
	FlP+y2Y69zKY2x1e/gdFFbGaVxZwy/en/de0F3x5FAPp9de/SlnwAOTCnIyAHNgRp9+br9SRso9
	YkYxqa3Qsmdn5jpfrZatEk6b9qYxSYJPxYWfxKoZl3R5MtN94Zt90OGXvoIYnPiKeCkd3OJs5rs
	EoZwxKYzKNt28+iBJSdtw/mHIprVskJscwCRf2SORXmdtkE3LhPIsu3+eNjICGKnHEwsTHF9aWB
	jW6typDEEHGZCKW/RT15rq4tpBh3OsjV7oMXMa7AOmMHTVL8m6pYNt4YDn
X-Received: by 2002:a05:600d:4:b0:485:34a2:919e with SMTP id 5b1f17b1804b1-486ff02af67mr62756755e9.33.1774077350959;
        Sat, 21 Mar 2026 00:15:50 -0700 (PDT)
Received: from localhost.localdomain ([103.27.167.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe88ef4esm35033565e9.10.2026.03.21.00.15.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Mar 2026 00:15:50 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: hsiangkao@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org,
	newajay.11r@gmail.com,
	nithurshen.dev@gmail.com,
	xiang@kernel.org
Subject: Re: [PATCH] erofs-utils: fix resource leaks and missing returns on error paths
Date: Sat, 21 Mar 2026 12:45:42 +0530
Message-ID: <20260321071542.80503-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <d8e7345e-a1cb-4234-b03f-a3089f7a1c27@linux.alibaba.com>
References: <d8e7345e-a1cb-4234-b03f-a3089f7a1c27@linux.alibaba.com>
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
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.ozlabs.org,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-2902-lists,linux-erofs=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:newajay.11r@gmail.com,m:nithurshen.dev@gmail.com,m:xiang@kernel.org,m:newajay11r@gmail.com,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D3B622E3EF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Xiang,

Thanks for the suggestion.

I have started working on formalizing the truncated image
scenario into a test case for experimental-tests. I'll 
implement it so that we can automate the image corruption
and verify the FUSE daemon's error-handling behavior in
future.

Since there is already a test-case I sent with code 028,
is it okay if I send this one with 029?

I will send the patch for the test case shortly.

Thanks and Regards,
Nithurshen

