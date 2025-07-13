Return-Path: <linux-erofs+bounces-602-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4189EB0323B
	for <lists+linux-erofs@lfdr.de>; Sun, 13 Jul 2025 18:55:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bgBQd2Hnqz3bkL;
	Mon, 14 Jul 2025 02:55:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::b36"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752425721;
	cv=none; b=GtY9aspTSP/XFS+b3Q+V+LveKYRx7zmCmj4Ofvkc3Euzjs7XqwtBvc3iuRWjME3RZwkBra0cszHHHzDEmK4HJBblRa24Fgy/DvddBPW5VKDCW+GzlyuWd7xUP8v4n0LzrZ7TZ2bwlzq3EoN4SXQV/0fuyly5K1HMDgQbBX4eECH8PduiClPaj9Pqsasa92W1hDLnjXRYJ5y2llCbvcF+SEb+gbsA8c5rOMfJQsFj2LaiFKsAI3VT7smTgvUMRgKYPZbcM91l7iakJ7Rc8Lgs/7SBMlsxpSe+WzNgzN3rCYCtp6I+2nU/XxIsD2hEsxPT2EkrYn4RKt7OFA2s6sfiQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752425721; c=relaxed/relaxed;
	bh=sgEEsXi7M/FefltXwa+r2QHZXdOG891MG8fVVpsnS3A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jnzc516Y03Zm1gOFyG17MF1vH8N1+1SsoBJ+gZkp0j7A6lFXFT5T/iuATy+Hgi4PoWYzGNjOzkLZB0joegMXlPhoJFRa8pv6FZD0dOewxDzmjAeqrcr9oJARDUhQ1xCCFeVKfacqhi/ngCTZMkZ4Un8WeaJwlA6Fg3vgedA8xiIbstPjHx23TNfX6rdp4EBkQa7c6unPFYnsG9UwCx2/e5Bw9e2I35FFiqiKTrBslBlzP+ZEaWVJPvbFZR5vbWxfKMjvLixz9JBI8x1kdAR3oHvX1isGSvxKN7K+lR+/liw/+JTho5yNV5j6jX9BPOvEylTrFxfHT6lk7khO9qTx1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Lh7GGUtG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b36; helo=mail-yb1-xb36.google.com; envelope-from=arthur200126@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Lh7GGUtG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b36; helo=mail-yb1-xb36.google.com; envelope-from=arthur200126@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bgBQc37sfz3bh6
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Jul 2025 02:55:19 +1000 (AEST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-e8b67d2acfbso3194443276.2
        for <linux-erofs@lists.ozlabs.org>; Sun, 13 Jul 2025 09:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752425717; x=1753030517; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sgEEsXi7M/FefltXwa+r2QHZXdOG891MG8fVVpsnS3A=;
        b=Lh7GGUtGshle0iDuV697tVhSm/oprTE31MorVkpO24HdMEa0gByFP8hHZQgggU3AXO
         L3Ack4VvzwCAiVXDEgN8JlB+d4ZFJ2hI7BXSscWkuiVps4zYQ0zArlDXGgk3DpkjNDDv
         5T9+FumV/eRG6qCoLlySIbqEa6JE01MtS+fr2YkasRfNMXwugHOnSMrgZdGvR0ajGhAH
         XuFfLKQtfCy3kIUlyZYRjW3X+h+eTWFyjSfjVQMmQw+EAlyg7NFsBkrZq63jw7ZQoweQ
         4lS4dXCq1ciDSUggN+jvuGu9i+tWoC3nhUJw4gYnOvuUa0MOBKwZxF3j7Rpl+gk13DJ9
         UlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752425717; x=1753030517;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sgEEsXi7M/FefltXwa+r2QHZXdOG891MG8fVVpsnS3A=;
        b=q18sf+F2NnDBJv9bEZs6sNYp/P5wCBA3SvBFpZvN4G+ZM64h8jDeQHXJB+CQZw+sOj
         6FPqaiVRZzX688h3NHNgqi0a454s/g+yyjABzj7ndnJXKQCOocla+uvzdMP8vtIWzAE9
         JHEs7JuThpgF6cC68pLwmNpIBy7mNYg4923/Od78Wd4oe6a7gGBs1U8hF57HEXeO1Tbm
         cMvb/rsb40SJXKl9AS5AXiewB3k5PZ/H3WKRg0hJnAQxQhCRzvs7ys5mxmGNlvH34oX1
         /nDOn2bunU6Ln9kIwSDECOtuekOP10PHKiaeesTfZBPoaZjFcPou64CD946g/EMGoEq3
         nYOA==
X-Gm-Message-State: AOJu0YxkOuhPzEAM/Yom790oIsJBBxclLnsgAh8edBwSu+sbEEy20LLd
	A8WKIdSU5rH9clSn9ljTNQheL0KHLEYBn9ZgUqNjnyijZ9cApgshURhDTEEK52FGlZs3TCqOaJh
	C32bspJnixaze5XlH3Xti3HOjucCtSZbbwktf1IQ=
X-Gm-Gg: ASbGncvS/O32sgg9JIK+6aCwS6AULAA57Z7vXlVsAzDJcv27rQi/xO068VvWKhNW93p
	HgrE6i13Nyly5uPQvKpxwNR2lmgpWvJEGDKb6Lvlok71QsvLfgxilDUotEsxQPXj1scO7p6TqwU
	RYeyB6loLTjJRVbDPBkbpkMzesE8tb7oqxSZkVr1FJZsspFI6W31NTzSTD19FHR14YvBDj7+SDA
	0o2CZfUeg==
X-Google-Smtp-Source: AGHT+IF+xJ9qxDnDreojBui7vQKakLAPes+LSvUgB7xPydy6N2aP31vvJ/5X8ohbRGoXpFbkePA9FYLbPMRH0UuYFJA=
X-Received: by 2002:a05:690c:4a0e:b0:708:be8b:841e with SMTP id
 00721157ae682-717d5e4dbaamr163826087b3.36.1752425717464; Sun, 13 Jul 2025
 09:55:17 -0700 (PDT)
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
From: Mingye Wang <arthur200126@gmail.com>
Date: Mon, 14 Jul 2025 00:55:06 +0800
X-Gm-Features: Ac12FXxDymTixJKqkK1UEQUskY_i3VU6GZbJyOYrq24AAawVDygjZKNz4v_sMh0
Message-ID: <CAD66C+YsAUG2Qtt9i5vbn5qPRfE0OHtAwyTUiZJaYrzrkTfYDg@mail.gmail.com>
Subject: Re: [feature request] extract a single file from EROFS filesystem
To: hsiangkao@linux.alibaba.com
Cc: linux-erofs@lists.ozlabs.org, derez@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi all,

>Gao Xiang Thu, 09 Jan 2025 01:36:16 -0800
>On 2025/1/9 02:14, Daniel Erez wrote:
>>Would it be applicable to introduce an option for extracting a specific file
>>from the image?
>>I.e. something similar to the '-extract-file' option available in unsquashfs tool [2].
>I will add this later.

I am seeing a need for a similar feature in making dracut's lsinitrd
work... a little better. I should add two cents of my own.

* In "unsquashfs" there's not only '-extract-file' for passing in a
list of files, but also a possibility for a list of paths to be
specified directly as arguments. This would appear outlandish on an
fsck utility.
* When extracting single files it might be desirable to *not* verify
and pretend-extract the other files.

Because of these two reasons, I think it might be best to make an
"unerofs" for extraction purposes instead of adding more things to the
"fsck" tool. An initial version can just be a separate "main" fuction
in fsck.c that gets used when an argv[0] equal to "unerofs" or ending
with "/unerofs" is found.

Sincerely,
Mingye Wang (Artoria2e5)

